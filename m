From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 13:17:27 +0200
Message-ID: <201002171317.27896.peter.ujfalusi@nokia.com>
References: <4B7AE1AD.7080400@mlbassoc.com> <201002171226.05108.peter.ujfalusi@nokia.com> <4B7BC86C.8040905@mlbassoc.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61944 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0BQLRo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 06:17:44 -0500
In-Reply-To: <4B7BC86C.8040905@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>

On Wednesday 17 February 2010 12:43:56 ext Gary Thomas wrote:
> On 02/17/2010 03:26 AM, Peter Ujfalusi wrote:
> > On Wednesday 17 February 2010 09:03:39 ext Jarkko Nikula wrote:
> >> On Tue, 16 Feb 2010 11:19:25 -0700
> >>=20
> >> Gary Thomas<gary@mlbassoc.com>  wrote:
> >>> I need to connect the OMAP (3530) to a 24bit CODEC.  So far
> >>> my attempts at getting this to go have not gone well.  Then
> >>>=20
> >>> I ran across this comment in sound/soc/omap/omap-pcm.c:
> >>> 	/*
> >>> =09
> >>> 	 * Note: Regardless of interface data formats supported by OMAP =
McBSP
> >>> 	 * or EAC blocks, internal representation is always fixed
> >>> 	 16-bit/sample */
> >>>=20
> >>> Does this mean that this setup is just not supported?  even thoug=
h
> >>> the hardware can handle it?
> >>=20
> >> Yep, comment is bit misleading but true until some patch will remo=
ve
> >> it. IRCC, the EAC was limited to 16-bit and also there wasn't need=
 and
> >> HW to test other formats than S16_LE in McBSP DAI.
> >>=20
> >>> Thanks for any pointers or ideas on how to get this going.
> >>=20
> >> I would first start adding support for the S32_LE into omap-pcm.c =
(DMA
> >> part). Worth to look this thread:
> >>=20
> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/=
024704
> >> .ht ml
> >>=20
> >> Then add support for this format to the omap-mcbsp.c (link
> >> configuration part).
> >>=20
> >> Next step would be to add support for the S24_LE on 4-byte boundar=
ies.
> >> I.e. the DMA is moving 32-bit samples between the memory and McBSP=
 but
> >> only 24-bits are transferred over the McBSP and codec.
> >=20
> > Hmmm, I think this is a bit more complicated than that at least on =
OMAP3.
> > I think the DMA engine should also move 24 bit words.
> > This is dictated by the McBSP FIFO: it has a notion of word size, a=
nd it
> > is expecting that the DMA engine will move THRESHOLD number of word=
s. So
> > if the McBSP is configured for 24 bit words, than the DMA word size=
 has
> > to match that.
> >=20
> > Apart from this, the constraint set for the period bytes need to be
> > changed since as you change the word size in McBSP you will have
> > different amount of actual bytes for the FIFO (the FIFO size is in
> > words, and the maximum word size is 32 bit).
>=20
> Thanks for the help.  I'm pretty sure I understand how to change
> the McBSP code (omap-mcbsp.c) to handle the various formats, but
> I'm a bit lost in the DMA setup (omap-pcm.c).  How do I identify
> the code/width in omap_pcm_prepare()?

After looking at the TRM of OMAP, the sDMA has support for 8, 16 and 32=
 bit data=20
types. So I'm not really sure how to configure McBSP and sDMA in case o=
f 24 bit=20
packed format.
I would go with a trial and error method and find it out how it is work=
ing...

> Has no one ever used the OMAP/McBSP with data sizes other than 16 bit=
s??

At least I can not recall. I have had a plan to add support for these, =
but it=20
got delayed and delayed ;)

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
