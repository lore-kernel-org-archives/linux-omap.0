From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: omap-mcbsp: Remove restrictive
 checks for cpu type
Date: Thu, 12 May 2011 00:49:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BBE2A29@dbde02.ent.ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>,<4DCAD29A.5050408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59676 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab1EKTYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 May 2011 15:24:13 -0400
In-Reply-To: <4DCAD29A.5050408@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

From: Steve Calfee [stevecalfee@gmail.com]
> Sent: Wednesday, May 11, 2011 11:46 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; Girdwood, Liam
> Subject: Re: [alsa-devel] [PATCH] ASoC: omap-mcbsp: Remove restrictive checks for cpu type
> 

[snip]...[snip]

> 
> Hi,
> 
> I removed all but the linux-omap list for my question.

[sp] Using a separate thread for this issues would have gotten more eyes!

> 
> I am trying to get the beagleboardxm to work with an external codec. I
> am trying to use a mcbsp1 via the trainer board where it level shifts to
> 5 volts. I have applied this patch (I am on 2.6.39rc4), but still no
> joy. I have a small analyzer attached to the I/O pins and important
> things like the bit clock does not wiggle.
> 
> First a side question. In the arch/arm/mach-omap2/Kconfig when I select
> BEAGLE, it selects OMAP_PACKAGE_CBB - but my bbxm system reference
> manual says "The BeagleBoard-xM processor is the DM3730CBP 1GHz version"
> which to me implies the proper package selection should be
> OMAP_PACKAGE_CBP. The platform file mux34xx.c has different tables for
> them, but I cant quickly tell the difference. Does this matter for mcbspx?

[sp] Check this page to find the differences:
     http://processors.wiki.ti.com/index.php/OMAP35x_To_AM37x_Hardware_Migration_Guide

~sanjeev

[snip]...[snip]
