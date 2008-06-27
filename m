From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: FW: [PATCH 00/05] 34XX cpu idle patches - core off
Date: Fri, 27 Jun 2008 16:54:18 +0300
Message-ID: <20080627135418.GG4509@codecarver.research.nokia.com>
References: <008101c8d091$27d64bd0$68bf18ac@ent.ti.com> <20080619114823.GB4953@codecarver.research.nokia.com> <001d01c8d203$5cac7500$68bf18ac@ent.ti.com> <20080619120507.GC4953@codecarver.research.nokia.com> <001e01c8d205$a89ed4b0$68bf18ac@ent.ti.com> <20080623144018.GC4468@codecarver.research.nokia.com> <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36537 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbYF0Nyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2008 09:54:46 -0400
Content-Disposition: inline
In-Reply-To: <008201c8d84d$0577d540$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: igor.stoppa@nokia.com, sawant@ti.com, linux-omap@vger.kernel.org

On Fri, Jun 27, 2008 at 05:27:48PM +0530, ext Rajendra Nayak wrote:
> Hi Peter,
> 
> I have the CORE off working on top of Jouni's latest patch set posted on l-o.
> 
> 2 issues which I saw due to which CORE OFF was broken
> 1) Control module registers were redefined with the same name in control.h while my patches 
> defined them in cpuidle34xx.h. In control.h they were just offsets and in cpuidle34xx.h they were defined as physical address.
> While saving the control module context, the offset was getting passed to omap_readl resulting in a crash.
> 2) GPIO clocks disable was moved into SRAM code in Jouni's patch, which would not get executed in OFF path.
> 

Thanks. I'm testing them now. 013-TIPATCH-fix-core-off.patch patches
include/asm/arch/control.h which doesn't exist on a non-configured
kernel. It's better to have the patch modify
include/asm-arm/arch-omap/control.h.

Cheers,

Peter.

-- 
goa is a state of mind
