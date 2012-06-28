From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 18:27:24 +0300
Message-ID: <1340897244.5037.140.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	 <1340881815.5037.53.camel@deskari> <4FEC47FA.1040801@linaro.org>
	 <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
	 <1340890278.5037.91.camel@deskari>
	 <CAJe_ZheBbj3qoECDokcxHsB4UOx354G5t_MfYiZ3UEm9xK=tqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-j0b9D0uW4ti3uaD2eEzy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:35822 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520Ab2F1P13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:27:29 -0400
Received: by lbon10 with SMTP id n10so5831101lbo.27
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:27:26 -0700 (PDT)
In-Reply-To: <CAJe_ZheBbj3qoECDokcxHsB4UOx354G5t_MfYiZ3UEm9xK=tqw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org


--=-j0b9D0uW4ti3uaD2eEzy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 20:44 +0530, Jassi Brar wrote:

> I won't press further with my Utopian ideas, but I think we need to
> segregate 5V/HPD enabling from PHY enabling somehow. Because that is
> already failing slow but otherwise perfectly legit displays (like
> Andy's "HPD taking 700ms" TV)

Yes, I agree. That's what the four power states I suggested in the other
mail were about. The second power state would have HPD enabled, and the
third would enable the PHY. Or at least enough to do i2c transfers, I'm
not sure if the PHY is needed for that.

> > And also, as I said earlier, if you keep it enabled all the time, it'll
> > eat power even if the user is never going to use HDMI.
> >
> > On a desktop I guess the power consumption wouldn't be an issue, but I
> > do feel a bit uneasy about it on an embedded device.
> >
> As I said, it should be platform dependent. If a device doesn't have
> HDMI port, the board file would not even have platform_enable. And if

Not that it's relevant here, but I have a patch series where I remove
the platform_enable stuff for HDMI, and move the work to the hdmi
driver. That needs to be done for device tree stuff, when we don't have
board files.

> it has, some user action should enable it while 'making the device
> ready for new display'.
> IOW, how do you envision an OMAP4 based tablet with HDMI port react to
> display connections ?

I guess this was covered in my mail about the phone's HDMI. If the
tablet is unlocked, and I plug in a HDMI cable, I expect the device to
do something. Either clone the display, or perhaps ask me what I want to
do.

So yes, HPD would be always enabled, when the tablet is active
(unlocked).

> >> HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
> >> HDMI_PHY on/off.
> >> The user selecting "Autodetect and Configure" option would then equate
> >> to "(un)loading" of the HDMI driver.
> >
> > HDMI cannot be currently compiled as a separate module. Although I thin=
k
> > you can detach a device and a driver, achieving the same. Is that what
> > you meant with unloading?
> >
> Yeah, I meant something to the effect of bringing HDMI driver to life.
>=20
>=20
> > By the way, when the device is in system suspend, we surely won't detec=
t
> > the HPD even if we kept the HPD always enabled. So there we'll miss the
> > HPD interrupt anyway, and the EDID cache would be invalid.
> >
> If omapdss already handles the possibility of display changed during
> suspend, I think we should be good :)

Hmm I'm not sure I understand what you mean. I was referring to your
patch, which invalidated the EDID cache only on HPD interrupt when the
cable is unplugged. And we'd miss that interrupt when the board is in
system suspend, even if we otherwise kept the HPD interrupt always
enabled.

 Tomi


--=-j0b9D0uW4ti3uaD2eEzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7HfcAAoJEPo9qoy8lh71wb4P/A6zeFHpdYA9nDWyJPPxznjU
ImHzs1NdlpqlAm96JJQG1h49vUN/XAkIxQxtt9Fxg3ES7rEp1Y0ME7UeSFwBcpA8
NRbY4xjWiMCjdUeq/DnrbJxWF7OVlEbrBgMzt4kC0FcKrlqdkpgSwfWLdvshy3Nb
CPwKAlXzvxYzptEJfIfQiQt/89kRwQs2D4sEcPvte9Dk06bTaNWoe/+GF8V+rEqb
UfWPHeb8hxmkcDofp+Y9d4rbviumb3LFKeAM1r2y+ctxYdUaBROQSubJ7a0hbuCK
44te7ON/5/CedjMsQeiXSdqbclxfcvWza8noPl7fBJ2nfK453f/xdyb3w2MnIbFr
vKIp3LERa+KRrH5LMalRDSLJdOeBIlC9E/pcbRwXu5x4qHAk9Fk648G3OWN+/Hnr
Jvw6wIRUYzk7XuI8vCVRzPUzcwF0xGBWzVOf7rwkIt2WpFCV00B8cTR6f4b8bg9i
fSqVjN3dAvTFpS57ecwaXtC9UkjquWQpX10n11xXCRJvA65FDwjTgon3jy7X2NF4
RgEkqYylcin+Zgg4/QRO4UOhTC2rCL03d8DfzDTrLvqZzyy61vMMl8dBy76ePk4G
lhlrZLNFSkJ2zQho3A44KI6FAGdetjSnVXPoiS78hV/0u7PcMH0pHg2r6PTIDR+k
t1fToWnC/jffYqkYIdcP
=hiGu
-----END PGP SIGNATURE-----

--=-j0b9D0uW4ti3uaD2eEzy--

