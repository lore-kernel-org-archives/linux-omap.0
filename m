From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 15:24:36 +0300
Message-ID: <1340022276.4012.23.camel@deskari>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340007094.1859.3.camel@lappyti>
	 <CAJe_ZhdhBre8DUVNpawF6X5P+QSiMarkt3WUvbJ=RPcmpX3TPA@mail.gmail.com>
	 <1340016865.4012.10.camel@deskari>
	 <CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-iVt8kFu/tGzRgkI8mm8M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40105 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442Ab2FRMYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 08:24:44 -0400
Received: by lbbgj10 with SMTP id gj10so5286087lbb.23
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 05:24:36 -0700 (PDT)
In-Reply-To: <CAJe_ZhfJV6kYvSkU+4RGywv80A47=CxnoCy2rr-x=c2LFDGb7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-iVt8kFu/tGzRgkI8mm8M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-18 at 17:16 +0530, Jassi Brar wrote:
> On 18 June 2012 16:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2012-06-18 at 15:42 +0530, Jassi Brar wrote:
>=20
> >> BTW, coming to think about it, I am not sure what we need the
> >> spin_lock_irqsave() protection for in hdmi_check_hpd_state() ?  It
> >> can't control HPD gpio state change and hdmi_set_phy_pwr() seems too
> >> expensive and is already unprotected elsewhere.
> >
> > It's needed when enabling the hdmi output. In phy_enable() the irq is
> > requested first, and then the phy_enable() runs hdmi_check_hpd_state().
> > So there's a chance to run hdmi_check_hpd_state() from both
> > hpd-interrupt and phy_enable() at the same time.
> >
> > The hdmi_set_phy_pwr() is not called in many places, but I think there'=
s
> > indeed a problem there. It is called after free_irq(), but I think
> > (guess) the irq handler could still be running after free_irq. So those
> > should be protected by the same spinlock too.
> >
> You know TI HDMI better than I do, so I assume your concerns are valid.
> So preferably I would move request_threaded_irq() to after
> hdmi_check_hpd_state() in ti_hdmi_4xxx_phy_enable()  and convert the

No, you can't move the check. If you move it, the HPD state could change
between the check and the request_irq, and we'd miss it.

> spin_lock_irqsave() in hdmi_check_hpd_state() to some mutex (we don't
> want irqs disabled so long as it takes for phy to power on/off).

Yes, I guess a mutex is better.

 Tomi


--=-iVt8kFu/tGzRgkI8mm8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP3x4EAAoJEPo9qoy8lh71ShYQAI71zD9g/VLMn7sq3pUOERMO
FrtVKdJPQNyKFhXOVujpS3RxVEykpDFO5vZq5MnAuqJlkWShuoYKaPmaSCnQZytx
WMjMHi6MkqXoezkz/SIdb5Y3zGOTGW0Eqq0naqp4POYGkNl+kZ6UWLHd+nbBoTbs
VMqW9B0wm6g2UhQtoM1x8gppgmX7e/xkXiG62MaLZ35YyueSTWL/kKIAbSVM9C70
sYFL09VKYci7o99SSDIlo1dxopfV5q88VNmRCFBHVhLvrLLxfSjbZEF2tI2kIvwZ
KvgFVPBeo1Td882KqNbNqIRh5voVMvTzwAtJm0SfAO1q/HKv+MwvgnWmOxINR6tB
/nzgSC7grdMX41WJIB4JoPyAoMv79yApMMfOVmjn66XG5Vbs1l7DoLsHOn7Lt0vr
SUDINvD8+5rgsE+54HE3scTeSgVgspqqxE4u0r4kHZsVrwfL0xxsZavTDHYsRT75
7oNb9UAqHNAuYLwyjNNIWkMogTuCBHdl9sCbTO63jVmZtYSpoxMhyK/sx+hPP0E6
z+Q/pTqfy0/BKIkfGv653sy22YYDsc1h+B/e/YW9Vp7TNjpyUTKxAgveBLTM4vqg
5s4YbPoXr0WeM9YMs2Bp3R+GTiCr07FzIDJiQts7YkXD2lmXPLKpgBdBR1ckaOXs
NIXCJ54nqWv/hNTFiLZX
=A9hE
-----END PGP SIGNATURE-----

--=-iVt8kFu/tGzRgkI8mm8M--

