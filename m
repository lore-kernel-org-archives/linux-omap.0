From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Mon, 25 Jun 2012 15:41:34 +0300
Message-ID: <1340628094.3395.63.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-J2QZT5Es6O4qR7j2h87Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:49898 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756365Ab2FYMl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 08:41:29 -0400
Received: by lbok6 with SMTP id k6so8100015lbo.32
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 05:41:26 -0700 (PDT)
In-Reply-To: <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-J2QZT5Es6O4qR7j2h87Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 17:57 +0530, Jassi Brar wrote:
> On 25 June 2012 15:00, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> > The driver needs to enable the HW and the call to pm_runtime_get() is
> > skipped. Won't this lead to crash as the DSS registers are accessed
> > without the HW in enabled state?
> >
> Hmm...  how does the extant code in hdmi driver ensures DSS is up and run=
ning ?
> While it does sound important even to my limited knowledge of OMAPDSS,
> I see rpm of HDMI, VENC and RFBI only dependent on DISPC, not DSS.

DSS device is parent to all the DSS subdevices. So when a subdevice is
enabled, DSS device is enabled first.

But anyway, I wasn't referring to the DSS part of OMAPDSS, but to
omapdss generally. If we do this:

/* this is skipped, if runtime PM is disabled */
dispc_runtime_get();

/* this accesses a register, but the HW is disabled? */
dispc_read_reg(FOO);

So again, I don't understand how the underlying HW gets enabled. Or does
hwmod/omap_device code make sure that it's enabled while the board is
being resumed? If so, what would happen if we continue the above
scenario as follows:

/* this is skipped, if runtime PM is disabled */
dispc_runtime_get();

/* this accesses a register, the HW is kept enabled by hwmod */
dispc_read_reg(FOO);

/* at some time later the resume procedure ends, and hwmod doesn't keep
the HW enabled any more */

/* this accesses a register, the HW is disabled */
dispc_read_reg(FOO);

> And for DISPC these drivers already hold a reference in their display
> enable/resume and keep it until disable/suspend. So we don't lose
> DISPC anytime it is really required.

If all the displays are disabled, nobody keeps a reference to dispc.

> > And what happens if the pm_runtime_get() call is skipped, but pm_runtim=
e_put() is not?
> >
> Not sure in what newly introduced scenario by this patch, because
> get/put both check for pm_enabled before proceeding. Am I overlooking
> something?

Currently (for example) dispc_runtime_get/put call
pm_runtime_get/put_sync. When somebody uses dispc_runtime_get, the same
somebody knows it needs to call dispc_runtime_put later.

Now, what happens if dispc_runtime_get is called when runtime PM is
disabled (i.e. pm_runtime_get_sync is skipped), but runtime PM is
enabled later when that somebody calls dispc_runtime_put (i.e.
pm_runtime_put_sync is _not_ skipped)?

 Tomi


--=-J2QZT5Es6O4qR7j2h87Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6Fx+AAoJEPo9qoy8lh71wwgP/0QrgwiVX5MqD31IOP5rdR9F
p4AfYwdROE2UoeTCtFm/sPrTmwLTv16kYjO+qV9svpxALbToq5sPdDch7NNjInvW
usYkerda6mvREaZegZrRi746TO+8oxmxHXGQJcT0H+1JHpsJxV5xe47QkQeBnHZ6
OImxM6s06knrrKFsLG2ExVmlOb7MvwhI/I/006TK/vAVDpcAd33O+ewI8ruumaB0
u1DwEfBwYTufoSrspyO6UP6VEs8UiLHPH8hV/NFNNY6KeXfW1XDY21XAk9go4aom
cou/14kjxZ2mWSQ6w7mOfp7mdL9XAarBItV6wP4Je/YXqZfc68esfwyzqZ9L+7nb
KMQleB837MBWzXtApckG1W0hCVxhfjzpkU4GRqaZXPANh9oBrKPOru/3IHIAZC7h
3crBoEOQBWN90fdhs2MhiEWg+5XNLumPsxY+zuqrCtYRbB0TWZdd5F291K7cYqSP
czaXDIiCNDNZ+UVK48xIbHjQCnIzJbJYuBkkfETIxU9E45TsiQevPlrW/s1+GA/v
Fhxu7Tq8e1eleBgCsRzM7PjmX4XJU1lqxuhm6C00p/ss6Xq8MxCIaSoHHKaxMhy5
1tXe70tphyHqfo0DREVDoM5o6XgPQUfTWd+oHlw+RK1GvZNtTWNmaK86kHTfYyha
6RQBMYNpVduxFkdjzHe2
=QDFO
-----END PGP SIGNATURE-----

--=-J2QZT5Es6O4qR7j2h87Q--

