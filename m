From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 12:26:04 +0200
Message-ID: <201002171226.05108.peter.ujfalusi@nokia.com>
References: <4B7AE1AD.7080400@mlbassoc.com> <20100217090339.c11d2e8a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57693 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0BQK0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 05:26:14 -0500
In-Reply-To: <20100217090339.c11d2e8a.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Gary Thomas <gary@mlbassoc.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On Wednesday 17 February 2010 09:03:39 ext Jarkko Nikula wrote:
> On Tue, 16 Feb 2010 11:19:25 -0700
>=20
> Gary Thomas <gary@mlbassoc.com> wrote:
> > I need to connect the OMAP (3530) to a 24bit CODEC.  So far
> > my attempts at getting this to go have not gone well.  Then
> >=20
> > I ran across this comment in sound/soc/omap/omap-pcm.c:
> > 	/*
> > =09
> > 	 * Note: Regardless of interface data formats supported by OMAP Mc=
BSP
> > 	 * or EAC blocks, internal representation is always fixed 16-bit/s=
ample
> > 	 */
> >=20
> > Does this mean that this setup is just not supported?  even though
> > the hardware can handle it?
>=20
> Yep, comment is bit misleading but true until some patch will remove
> it. IRCC, the EAC was limited to 16-bit and also there wasn't need an=
d
> HW to test other formats than S16_LE in McBSP DAI.
>=20
> > Thanks for any pointers or ideas on how to get this going.
>=20
> I would first start adding support for the S32_LE into omap-pcm.c (DM=
A
> part). Worth to look this thread:
>=20
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024=
704.ht
> ml
>=20
> Then add support for this format to the omap-mcbsp.c (link
> configuration part).
>=20
> Next step would be to add support for the S24_LE on 4-byte boundaries=
=2E
> I.e. the DMA is moving 32-bit samples between the memory and McBSP bu=
t
> only 24-bits are transferred over the McBSP and codec.

Hmmm, I think this is a bit more complicated than that at least on OMAP=
3.
I think the DMA engine should also move 24 bit words.
This is dictated by the McBSP FIFO: it has a notion of word size, and i=
t is=20
expecting that the DMA engine will move THRESHOLD number of words. So i=
f the=20
McBSP is configured for 24 bit words, than the DMA word size has to mat=
ch that.

Apart from this, the constraint set for the period bytes need to be cha=
nged=20
since as you change the word size in McBSP you will have different amou=
nt of=20
actual bytes for the FIFO (the FIFO size is in words, and the maximum w=
ord size=20
is 32 bit).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
