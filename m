From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in
 TX_ON
Date: Fri, 02 Mar 2012 12:52:24 +0200
Message-ID: <1330685544.2184.7.camel@lappy>
References: <1330589664-15755-1-git-send-email-mythripk@ti.com>
	 <1330601462.2586.32.camel@deskari>
	 <CAP5A+B8uqQYq671=TQRm0LsYSfdDMoZY0koU4JH=MpA20HMj2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cGc8aKbuKX2vXSUpJhE0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35174 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab2CBKwc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 05:52:32 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so1932884laa.38
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 02:52:30 -0800 (PST)
In-Reply-To: <CAP5A+B8uqQYq671=TQRm0LsYSfdDMoZY0koU4JH=MpA20HMj2w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org


--=-cGc8aKbuKX2vXSUpJhE0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-02 at 13:35 +0530, K, Mythri P wrote:
> Hi Tomi,
>=20
> On Thu, Mar 1, 2012 at 5:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > Hi,
> >
> > On Thu, 2012-03-01 at 13:44 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> Currently TX_PHY is put to TX_ON(transmission state) on receiving HPD.
> >> It just ensures that the TV is connected but does not guarantee
> >> that TMDS data lines and clock lines are up and ready for transmission=
.
> >> Which although is very rare scenario has a potential to  damage the HD=
MI
> >> port.(A use case where TV is connected to board but it is in different
> >> channel would still trigger a HPD but TMDS lines will be down).
> >
> > When/how does the damaging happen? When the HDMI cable is disconnected
> > in the case above? Or does the damage just happen by having the cable
> > connected, but the TV on different channel?
>=20
> Damage never happens with the cable connected for a long time.. Damage
> happens only
> when the cable is connected when the PHY is in TX ON state. Which
> requires the following sequence to be followed.
> 1. Wait for HPD connect
> 2. Wait for the PHY connect ( TMDS lines are up)
> 3. Enable PHY
> We are currently missing step 2.

Doesn't HPD already tell us that the cable is connected?

> >> +             tmds_clk =3D hdmi_read_reg(hdmi_wp_base(ip_data),
> >> +                                     HDMI_WP_WP_DEBUG_DATA);
> >> +             udelay(15);
> >
> > This code doesn't make any sense, or the HDMI TRM is wrong. You read th=
e
> > same register, HDMI_WP_WP_DEBUG_DATA, four times, assigning the value t=
o
> > data0-2/clk. The TRM I have doesn't talk about anything like that. What
> > is the code supposed to do?
> >
> I am not very sure which TRM you have but the HDMI_WP_WP_DEBUG_DATA
> can also be used to probe the TMDS lines as well, but i might as well
> try pad config and let you know.

I have 4460 HDMI TRM vF and 4430 HDMI TRM vL. Both look the same
regarding the debug registers. Can you send me the latest ones that
explain the DEBUG registers correctly?

> > The register HDMI_TXPHY_PAD_CONFIG_CONTROL also has bits for RXDET_LINE=
.
> > Is that something different?
> >
> >> +     } while ((tmds_data0 !=3D tmds_data1 || tmds_data1 !=3D tmds_dat=
a2
> >> +                     || tmds_data1 !=3D tmds_clk) && (loop < 500));
> >
> > This is a rather confusing way to do the loop. Why not just use for-loo=
p
> > with the timeout, and check the tmds variables inside the loop. Much
> > easier to read.
> >
> > In the worst case the above causes a 7.5ms busy loop in an interrupt
> > handler. That's not very good thing. Why is there a need for the loop?
> I agree looping in interrupt context is bad.. That was the reason i
> had a threaded irq handler and i case even here it is the threaded irq
> handler i dont think it is happening in irq context.

We should nevertheless avoid 7.5ms busyloop if at all possible. Is there
an estimate of how long it takes for the PHY to connect? I think we
could just start a delayed work from the interrupt, and do the check
after a short delay. I don't think the user cares if the connect happens
after 1ms or 10ms from the moment the cable is plugged in =3D).

 Tomi


--=-cGc8aKbuKX2vXSUpJhE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPUKZoAAoJEPo9qoy8lh71DncQAIfnJcxXeziVYlFcdF46Rxcj
r+HbyDZCs8qk+LeJTHBhxsnMhUYY1hhziUh1nExxrBcYS4MMLOKszzjyC1baHLMK
GsEOfIFxsOvt+iypodDHU+Vo7+Kcc2+Aut4656BIbTAGwF050TVsBw0ScoxHIAE7
OCEbzo3gWGI3+dl08lWAKdxsw7Ge3fu32TdhdMO9YslhXWOAwY5OpFHjBAiZ9tT5
/sQ4n4yv+KWnXh+lMeuI6IK/rKTA9JKeWEmi1+LrTLCsC4Bq36z3ctySmr+jXYXY
Bie1TLwBl+A1lQ21vas8HXOHiURUwwVu0z8B4ISXMtZw8uQhaquTRLI69npB7t3Q
yFrJKfEMXNaVETXqX/MwZw+AJ2ty4NK9ghJmju4SVzphoekPKXgLyK3ZFy+31FYB
zyW/THr+HzRUcZa+nSizXCFkfB1Q9ZTSD6NQt1ESBWuUycgtPFsZu+ZYESD/2bCP
vukpdXVnQmU8O0vO8mHM+wMypwfORf/H9sEV4+Sze+9LhPIKEXFElRblnnBxe3NP
yoCU/BEr4cwxZq1HvU0gLUNC2hjSt164s8SNNKtJd50wdaiLhTjkL8hVQIxYRkMS
yffFb5/TkaFGynLLE5WsFZHh2p1wkb+EpCgGJyoFgohxgc6now3VabcP5vGjejoJ
wuKIterHUD59+JjWxTUE
=5OAy
-----END PGP SIGNATURE-----

--=-cGc8aKbuKX2vXSUpJhE0--

