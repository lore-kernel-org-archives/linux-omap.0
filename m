From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: eac and mcbsp for omap850
Date: Wed, 9 Dec 2009 10:06:15 +0200
Message-ID: <200912091006.15725.peter.ujfalusi@nokia.com>
References: <e7c6a05e0912080406y763b2e99nd0188ff1911ec829@mail.gmail.com> <20091208150547.a83f0e81.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23334 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZLIIGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 03:06:14 -0500
In-Reply-To: <20091208150547.a83f0e81.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Tuesday 08 December 2009 15:05:47 ext Jarkko Nikula wrote:
> On Tue, 8 Dec 2009 13:06:05 +0100
>=20
> Belisko Marek <marek.belisko@gmail.com> wrote:
> > Hi,
> >
> > I would like to rewrite old eac audio driver for omap730 to current
> > ASoc implementation
> > but as I can understand new implementation use McBsP to
> > transfer data to codec. Could this approach be used in omap850 whic=
h
> > use EAC like codec and data from memory is transfered via DMA?
>=20
> Basically it should be possible to develop a new ASoC DAI driver usin=
g
> EAC. Even currently there is only one McBSP based DAI driver
> sound/soc/omap/omap-mcbsp.c, there is no restrictions to develop anot=
her
> DAI drivers since the sound/soc/omap/omap-pcm.c is not tied to
> underlying DAI.

As I recall this is one of the reasons that Jarkko wants to keep the DM=
A and=20
McBSP related code separately (to have the possibility to add the EAC s=
upport=20
with the least code duplication).
As I recall on OMAP2 the EAC had some bugs, which prevented it's use in=
 certain=20
situations, thus the McBSP mode was preferred over EAC.

But yes, adding the EAC dai should be possible for OMAP.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
