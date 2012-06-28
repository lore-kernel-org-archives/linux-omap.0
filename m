From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 18:14:18 +0300
Message-ID: <1340896458.5037.131.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	 <1340881815.5037.53.camel@deskari> <4FEC47FA.1040801@linaro.org>
	 <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-96cmH2sjNRqU/YvAHvjR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33183 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459Ab2F1POX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:14:23 -0400
Received: by bkcje2 with SMTP id je2so1392224bkc.15
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:14:20 -0700 (PDT)
In-Reply-To: <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org


--=-96cmH2sjNRqU/YvAHvjR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 18:43 +0530, Jassi Brar wrote:

> A quick reaction of my guts say, we simply enable 5V/HPD_IRQ during
> probe and disable during remove.
> HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
> HDMI_PHY on/off.
> The user selecting "Autodetect and Configure" option would then equate
> to "(un)loading" of the HDMI driver.
> Not to mean a trivial job.

One more thing I realized while thinking about this:

While it could be argued that the power draw from having the tpd12s015
always enabled is very small, I think it could matter. If you consider a
phone with HDMI output, it's likely that the phone is locked 99% of the
time. When the phone is locked, there's no need to keep the HDMI HPD
enabled. So this could add to a considerable amount of power wasted, if
the HPD was always enabled.

At least I can't figure out a reason why one would want the HPD to work
when the phone is locked. Also, I have never used the HDMI output on my
phone, so I'd be glad if it was totally powered off if it gave me more
standby hours =3D).

 Tomi


--=-96cmH2sjNRqU/YvAHvjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7HTKAAoJEPo9qoy8lh71deoP/j2uDc8Lt2pcC8bDEFRBPhjR
+R1f3R1AsMeRe8eods4VOhGbMrI0EbZ2Rw9Qkckmo1cnnsN4zydJy8mAY5bizIx9
F8R5bH6q5znvd6e2N+NbKhESRCAzA99INQarXJXezCEc277XDrcyvrbkLn+aGBmG
IuvxBrgI26Ijde0sPd59CwBfnTlZmQojUy1yRP0TmM6PL4folY4j2K8B/jELf1ms
Zi0BWvBlCL3XOAjMMK88NqVA+9umCA4X13b47duC3s+STaTJuaGZeqZ/RsaLTy+b
AgZQWMucIbIMegelKUxR4qLwEhuBFOLO+2mDIwRR2DlgOl4DywTBpiBFdbnK0BsJ
91D+Q8H0pCdmYcrnsi8o64aFXPVDw+6z/6+6L+oy00BBkVWGn127VxnSMh+8i0B8
3FwZ716ixRin19HUdp5Xymgg7r8WSuWxk21dS04qCzBo99gPHIX7RJWCsBNxjFdR
FbfLBk2SYr+ddrouzl4avv+5YBwO0ILyQWXPXh+2F9jzykCDZ1TP1SjgfYJUn/MO
ItSO0vxq2nzAPkbwpLJJofh8OK7EjJuuR+19nhKY2PkKUBnlbGMIF0dt+mIkS0ti
lOuIeL9Rbjk5/QK2FY/bwRM2IyiaecSC8gXRCYUuBVjq4LqlnZmoOdha4yfHVOao
0RkdZM2wU7L8HvLrxlMJ
=ktqH
-----END PGP SIGNATURE-----

--=-96cmH2sjNRqU/YvAHvjR--

