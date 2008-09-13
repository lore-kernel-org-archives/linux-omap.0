From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Sat, 13 Sep 2008 22:27:41 +0200
Message-ID: <92846148-6506-47F1-8643-7333FB5E146A@student.utwente.nl>
References: <1221144955.12281.6.camel@tubuntu> <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com> <20080912152937.GP31563@intune.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-364809115"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:54064 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbYIMU2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Sep 2008 16:28:17 -0400
In-Reply-To: <20080912152937.GP31563@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: video4linux-list@redhat.com
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-364809115
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 sep 2008, om 17:29 heeft Daniel Stone het volgende geschreven:

> On Fri, Sep 12, 2008 at 07:59:44PM +0530, ext Shah, Hardik wrote:
>> It's time to re-design DSS frame buffer driver for the OMAP2/3.   
>> Current frame buffer driver is not covering the most of the  
>> functionality of the OMAP2/3 DSS Hardware like multiple outputs and  
>> multiple overlay managers supported by OMAP2/3 class of SoC. Again  
>> there is no V4L2 interface exposed by the DSS drivers for  
>> controlling the video pipelines of the DSS which is highly  
>> desirable feature as the video pipelines of the DSS hardware is a  
>> natural fit to the V4L2 architecture.
>
> If you want to use v4l for video output, don't let me stop you, but I
> don't see that it has much actual wide use beyond TI PowerPoint
> presentations about their graphical architecture.

That was my thought as well, but I've encountered at least 2 products  
this weekend at IBC using the v4l way on omap3. One of the engineers  
was complaining about the lack of synchronous updates if you move  
various videoplanes around (think resizing video windows) which makes  
the video picture end up outside your nice cairo-drawn borders. So  
yes, it is getting used outside of TI :)

regards,

Koen

--Apple-Mail-1-364809115
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIzCI/MkyGM64RGpERAifwAJ910Ma2PciJlr71QLNmlSdCuDoFFQCgqhf8
O41uzZk8LNhCC5ao3BHKI5M=
=Kn1q
-----END PGP SIGNATURE-----

--Apple-Mail-1-364809115--
