From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] omap: Fix omap_4430sdp_defconfig for make oldconfig
Date: Fri, 6 Aug 2010 18:42:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D047@dbde02.ent.ti.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com> <20100806070301.GA23778@atomide.com>
 <20100806070519.GB23778@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401CFA6@dbde02.ent.ti.com>
 <20100806115009.GL23778@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50809 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654Ab0HFNMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 09:12:38 -0400
In-Reply-To: <20100806115009.GL23778@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, August 06, 2010 5:20 PM
> To: Nayak, Rajendra
> Cc: Kevin Hilman; linux-omap@vger.kernel.org
> Subject: [PATCH] omap: Fix omap_4430sdp_defconfig for make oldconfig
> 
> * Nayak, Rajendra <rnayak@ti.com> [100806 14:22]:
> > 
> > Now with this, omap4 build using omap_4430sdp_defconfig seems to
> > go through, but like you said, boot is still an issue.
> 
> Hmm, I guess these issues pop up if you do yes "" | make oldconfig.
> 
> Can you try the patch below? After applying the patch, you need
> to:
> 
> $ rm .config
> $ cp arch/arm/configs/omap_4430sdp_defconfig .config
> $ yes "" | ARCH=arm make oldconfig
> 
> Then omap2 and 3 won't get selected by make oldconfig.

Yes, this seems to work.

> 
> Regards,
> 
> Tony
> 