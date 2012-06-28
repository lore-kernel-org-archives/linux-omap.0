From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 14:04:16 +0300
Message-ID: <1340881456.5037.47.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LDmmjb2W9ck8ChyOeU/O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36212 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539Ab2F1LEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:04:21 -0400
Received: by lbbgo11 with SMTP id go11so2877879lbb.3
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:04:19 -0700 (PDT)
In-Reply-To: <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-LDmmjb2W9ck8ChyOeU/O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 16:17 +0530, Jassi Brar wrote:
> On 28 June 2012 15:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> > When the display device is disabled, we're not listening to the hpd
> > interrupt anymore. So when it's disabled, the cable can be replugged an=
d
> > the monitor changed, and the driver won't know about it. And so it'll
> > return the old EDID for the new monitor.
> >
> If that could be a problem, then we already have some problem with
> current omapdss.
>=20
> I think among the first things, while enabling HDMI, should be to see
> if there is really some display connected on the port i.e, HPD
> asserted. Only if ti_hdmi_4xxx_detect() returned true, should we
> proceed otherwise wait for HPQ irq.

I'm not sure I understand. The HDMI driver does just that. It calls
hdmi_check_hpd_state when it's being enabled to see if there's a display
connected.

> Unconditionally invalidating edid really seems like a regression - we
> impose atleast 50ms (edid read) as extra cost on
> hdmi_check_hpd_state(), which kills half the purpose of this patch.

If the HDMI hardware is turned off, we should unconditionally invalidate
the EDID. We have no way to keep track if the same monitor is kept
plugged in or not.

So what exactly is the purpose of this patch, what kind of scenario? I
thought it's to cache the EDID, so that if it will be read multiple
times while the same monitor is connected, we'll just return the cached
value.

Of course, I don't know why the upper layers would read the EDID
multiple times, because I think they should read it only once. So
perhaps I'm either not understanding something, or it's the omapdrm
layer that should be fixed?

 Tomi


--=-LDmmjb2W9ck8ChyOeU/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7DowAAoJEPo9qoy8lh71TAgP/00IdBKML41CtJs/hWrR8TxS
HL9wt98IjS+a4oWNHj/o+HRF4KQz4eakEQ0slXZNV0YoXoHEzj+Qa5CaXocqN90z
6ixsNvj+IC6wbR8PaWNItXTW8+2uHe3k49QOFV5DJhYNyrxyoG+syrBz9CxmFsiB
nGGnJbfw9wPgu+IV+GHqBK3UsA9RncjnewpNEzN/i1AK4nAgfjLtyr6dycqO9Y+X
tWhj4U2uNGRkJYAe7zK2UrBSxZDT3Bhgs1oBZWNKb3NBXxWgp60hblushflpiWWq
bjBlZFEfrHt7jOXGz+BDuuZkuZgP7N9m9Ks3eM3SB33kMdZg94Fh1/C8659gxKSI
ck3/O+2LwrZ1eibxYI8HM7+aFFmGJkCLWJKfpg8rGUcn9uXX+thefyChIMOjNWgL
0y8aacwhNhpmYDu+oBV7LikT8SCUT6VqV+ToV6O5q9GI5eNDVzd28JtNZBEloTUi
VCU4L+69e/3IJ9+/i1BvEIJy/gSh4f+7DDUGzmbYwFLBLFqlPzhNtIVfGsT0s13K
d+Hg55K3t6HAEqjMuvPuVBsLfYEYa90qg0uj0oEEc2ua5UUm6SZt1cemQ4L8GFAK
1rUy8M5W1q+DKm5ZO/AEBc4G88QhPLGQ5gocHNSNnypgTCcvoaoWZQNCJLagMLQd
depdQgSDFsdWl9Cgfm38
=lXHP
-----END PGP SIGNATURE-----

--=-LDmmjb2W9ck8ChyOeU/O--

