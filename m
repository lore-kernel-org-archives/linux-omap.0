From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in
 TX_ON
Date: Fri, 02 Mar 2012 13:38:46 +0200
Message-ID: <1330688326.1923.32.camel@deskari>
References: <1330589664-15755-1-git-send-email-mythripk@ti.com>
	 <1330601462.2586.32.camel@deskari>
	 <CAP5A+B8uqQYq671=TQRm0LsYSfdDMoZY0koU4JH=MpA20HMj2w@mail.gmail.com>
	 <1330685544.2184.7.camel@lappy>
	 <CAP5A+B_=Jr+iQourN__8Jaek7sR_PUOK_OCQ88q0Y7gaNzE4WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QBnj9CkPM25r8Jhccu43"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45146 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932135Ab2CBLiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 06:38:50 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so3381579lah.39
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 03:38:49 -0800 (PST)
In-Reply-To: <CAP5A+B_=Jr+iQourN__8Jaek7sR_PUOK_OCQ88q0Y7gaNzE4WA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, David Anders <x0132446@ti.com>


--=-QBnj9CkPM25r8Jhccu43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-02 at 16:55 +0530, K, Mythri P wrote:
> Hi Tomi,
>=20
> >> Damage never happens with the cable connected for a long time.. Damage
> >> happens only
> >> when the cable is connected when the PHY is in TX ON state. Which
> >> requires the following sequence to be followed.
> >> 1. Wait for HPD connect
> >> 2. Wait for the PHY connect ( TMDS lines are up)
> >> 3. Enable PHY
> >> We are currently missing step 2.
> >
> > Doesn't HPD already tell us that the cable is connected?
> >
> Yes HPD tells us that cable is connected but does not guarantee that
> the line is ready for transmission of data, HPD just means the DDC
> line is up.

Okay, but above you say "damage happens only when the cable is connected
when the PHY is in TX_ON". The HPD interrupt tells that the cable is
physically connected, right? And we set TX_ON after HPD, i.e. after the
cable is connected.

And below you say that this depends on which input the user selected
from the TV. So it sounds to me that this problem is not actually
related to the cable connect at all, but it's about enabling the PHY on
OMAP side before the TMDS lines are (somehow) in ready state?

What happens if the HDMI output is enabled properly, but then later,
while the output is still on, the user changes the input of the TV to,
say, AV1? And then, later, back to HDMI?

> >> > In the worst case the above causes a 7.5ms busy loop in an interrupt
> >> > handler. That's not very good thing. Why is there a need for the loo=
p?
> >> I agree looping in interrupt context is bad.. That was the reason i
> >> had a threaded irq handler and i case even here it is the threaded irq
> >> handler i dont think it is happening in irq context.
> >
> > We should nevertheless avoid 7.5ms busyloop if at all possible. Is ther=
e
> > an estimate of how long it takes for the PHY to connect? I think we
> > could just start a delayed work from the interrupt, and do the check
> > after a short delay. I don't think the user cares if the connect happen=
s
> > after 1ms or 10ms from the moment the cable is plugged in =3D).
> >
> Actually by using the PHY_CONNECT interrupt we can avoid the wait.
> If the TV channel is the same as the HDMI port connected to then there
> is hardly any delay between HPD and TMDS lines. Problem is when user
> connects to HDMI but is running  say AV1 /AV2  on TV.
> In such case we will see that HPD is high but TMDS lines are low, So
> there is no guarantee it will be done in certain period, as it is user
> dependent.
> So i am more inclined to have a interrupt based way, On receiving HPD
> in the threaded irq handler we can wait_on_completion of PHY_CONNECT
> which will put the thread in sleep until TMDS lines are high.
> I shall make that patch test out and post it soon.

Is there any reason to wait? Why not just enable the PHY_CONNECT
interrupt in HPD interrupt, perhaps set a flag, and exit. Then at the
PHY_CONNECT interrupt set TX_ON.

 Tomi


--=-QBnj9CkPM25r8Jhccu43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPULFGAAoJEPo9qoy8lh71WsgP/3ef6dpV+avNte2oetuyKLxp
rmT8m4zidSO7nBd0V6/nMwq75hhLmRhWrTWumjXXI456NYXkr/RbaxeyMI/zCDfQ
nz9iZIeXkqgnkoaATdTR59ltX2lcJh4IoNr1En5KA3+q9XjRZZsbApzJW5IrZQxS
6XV2H+B9PE4Ky14AnUApcNz05dBYJ22sf+Bwr4dYGzW5U4G0DJp/T3qECLjlkN+c
UuLrPw4Kxm8NqbOQj3oiUgXfJOxzGnvD7oOb7jY7mlh5aU/6cgHX/NWkdbJMXoc9
hd2dW2iZH3+4TcH7HnYwQlRDySDGf60Hl7r1fTFf13bqhUQ1kDI1U5SX8Ma8z/s5
75G+bXPtXginFsoGVeLfPzDMVD5mENdw53WT+7ToRo/XiSlww/8AI1S7ehprKGdi
zcdxGZkEN2rSmO5MyayTdL4kvdl2phKj9rnvysUGhbe2fzqMauVLjgYoicpGuTgJ
KRHSV9ZJrGtufhVd1PwNDbr6tR7ci3nvFEEMfyNK2QHFxb4HW3x9hUuVd3djoVw1
Sjy/mURsKfnq0/NEMiFo0SS47jJ8qdJC/hW5O5VL6ZjIUalHdCAPFUPPhO2VhlCb
DDPUjbhoTCsCaR1p5KA57uu047tW5wXz0aLqEVsRJHmuNsI5zPfTKz/QcYCrGVQb
spvRTgxJdV7+7EDP0L5v
=Zre/
-----END PGP SIGNATURE-----

--=-QBnj9CkPM25r8Jhccu43--

