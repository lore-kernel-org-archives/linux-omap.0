From: Peter Barada <peterb@logicpd.com>
Subject: Re: JTAG debugging of the kernel
Date: Mon, 18 Aug 2008 14:47:28 -0400
Message-ID: <1219085248.24975.118.camel@blackhole>
References: <1218812628.24975.89.camel@blackhole>
	 <0680EC522D0CC943BC586913CF3768C00208C16544@dbde02.ent.ti.com>
	 <1218823096.24975.108.camel@blackhole>  <48A5D19B.1050407@vocollect.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:10414 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755839AbYHRSra (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2008 14:47:30 -0400
In-Reply-To: <48A5D19B.1050407@vocollect.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Josh Karabin <gkarabin@vocollect.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2008-08-15 at 14:57 -0400, Josh Karabin wrote:
> Peter Barada wrote:
> > On Fri, 2008-08-15 at 23:04 +0530, Syed Mohammed, Khasim wrote:
> >>> -----Original Message-----
> >>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> >>> Barada
> 
> >>> Any suggestions on what can cause the JTAG to stop working after the
> >>> kernel starts?
> >>>
> >> I think you should disable Power Management. Which kernel are you using now?
> > 
> > 2.6.22.18.  I'm planning to move to 2.6.26 after the dust settles...
> > 
> > I'll try w/o power management, but any idea why power management might
> > affect JTAG?
> 
> The guy I share an office with (who's out on vacation) worked through 
> this with their tech support, who suggested replacing WFI instructions 
> with NOPs.
> 
> Look at cpu_v7_do_idle in arch/arm/mm/proc-v7.S.  Changing the WFI to a 
> NOP did the trick for him.
> 
> Presumably power management was off, but even WFI (wait for interrupt) 
> put the CPU in a state that wasn't handled by the BDI firmware at the 
> time.  I'm not sure if they resolved the issue in a later firmware 
> update or not.  We didn't think the workaround was worthy of a Kconfig 
> option - hopefully updated firmware for the BDI box will address the issue.

Hmm, trying both disabling power management and changing the WFI to NOP
in cpu_v7_do_idle does not work, the BDI times out when I try to halt
the processor.  I'm running with version 1.07 of the BDI firmware.  Is
this what other people are successfully using to debug the kernel with a
BDI-2000?

> 
> - Josh
