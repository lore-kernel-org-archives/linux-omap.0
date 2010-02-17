From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: OMAP Audio
Date: Wed, 17 Feb 2010 09:03:39 +0200
Message-ID: <20100217090339.c11d2e8a.jhnikula@gmail.com>
References: <4B7AE1AD.7080400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:57023 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933857Ab0BQG6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 01:58:33 -0500
Received: by ewy28 with SMTP id 28so2491519ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 22:58:31 -0800 (PST)
In-Reply-To: <4B7AE1AD.7080400@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

On Tue, 16 Feb 2010 11:19:25 -0700
Gary Thomas <gary@mlbassoc.com> wrote:

> I need to connect the OMAP (3530) to a 24bit CODEC.  So far
> my attempts at getting this to go have not gone well.  Then
> I ran across this comment in sound/soc/omap/omap-pcm.c:
> 	/*
> 	 * Note: Regardless of interface data formats supported by OMAP McBSP
> 	 * or EAC blocks, internal representation is always fixed 16-bit/sample
> 	 */
> 
> Does this mean that this setup is just not supported?  even though
> the hardware can handle it?
> 
Yep, comment is bit misleading but true until some patch will remove
it. IRCC, the EAC was limited to 16-bit and also there wasn't need and
HW to test other formats than S16_LE in McBSP DAI.

> Thanks for any pointers or ideas on how to get this going.
> 
I would first start adding support for the S32_LE into omap-pcm.c (DMA
part). Worth to look this thread:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024704.html

Then add support for this format to the omap-mcbsp.c (link
configuration part).

Next step would be to add support for the S24_LE on 4-byte boundaries.
I.e. the DMA is moving 32-bit samples between the memory and McBSP but
only 24-bits are transferred over the McBSP and codec.


-- 
Jarkko
