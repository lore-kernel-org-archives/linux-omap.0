From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 17 Aug 2009 22:51:46 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0037CB51FBE@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
 <20090807220016.GG31543@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
 <20090808170300.GA23481@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
 <20090813173327.GA14872@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com>
 <20090815153357.GF29616@n2100.arm.linux.org.uk>
 <20090815181711.GG29616@n2100.arm.linux.org.uk>
 <0680EC522D0CC943BC586913CF3768C003790C67DC@dbde02.ent.ti.com>
 <20090817165054.GR10764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47224 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbZHQRWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 13:22:08 -0400
In-Reply-To: <20090817165054.GR10764@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, August 17, 2009 10:21 PM
> To: Syed Mohammed, Khasim
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> 
> On Mon, Aug 17, 2009 at 04:40:27PM +0530, Syed Mohammed, Khasim wrote:
> > This patch seem to be working, I don't see any dump like before.
> 
> Great.
> 
> > Can you please advice on how to get this patch into kernel? I mean,
> > will you be handling it or we need to re-submit them with your signed off?
> 
> Yes, I'll be sending it.  However, I believe the patch I sent contains
> one error:
Thanks.

> > > +static int __init meminfo_cmp(const void *_a, const void *_b)
> > > +{
> > > +	const struct membank *a = _a, *b = _b;
> > > +	long cmp = bank_pfn_start(b) - bank_pfn_start(a);
> 
> I think this should be bank_pfn_start(a) - bank_pfn_start(b).  When you
> tested this unmodified patch, did the "Memory:" line list the memory
> bank sizes in reverse order?

Unmodified results in

MEM: unordered memory banks.  Not freeing memmap.
Memory: 60MB 88MB = 148MB total

Making it a - b results in

Memory: 88MB 60MB = 148MB total

a-b is correct one, fortunately both worked for me. 

Regards,
Khasim
