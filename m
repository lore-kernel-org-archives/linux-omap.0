From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Tue, 09 Dec 2008 11:15:00 +0200
Message-ID: <1228814100.8668.100.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54884 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYLIJPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 04:15:44 -0500
In-Reply-To: <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> nice test case.
> 
> On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
> 
> > I have had strange clk_enable() crashes with DSS2, and now I managed to
> > isolate it. With the included patch, on OMAP3 SDP board, with default
> > kernel config, I always get the crash below. In this example case it
> > happens at specific time on boot, but with DSS2 it happens randomly at
> > runtime, when I enable the DSS clocks.
> 
> Looks like there's some problem with the DSS driver's usage of 
> dss_tv_fclk.  Enabling dss_tv_fclk before entering your test code's 
> while-loop makes the problem go away here.  Patch below.
> 
> As an aside, your test patch does not actually disable dss1_fclk, since it 
> is already enabled by the time the while-loop starts.  So you might also 
> want to add a clk_disable(c2) before your while-loop starts, when you 
> test.
> 
> Based on the traceback that you sent, I'd conjecture that probably some 
> part of the DSS subsystem is generating an interrupt via DSS_IRQ; but then 
> dss_iclk ends up disabled, and the MPU INTC is not able to communicate 
> with the DSS, and the INTC wedges.  (The aborting access is to 0xd8200098, 
> the INTCPS_PENDING_IRQ0 register, rather than a DSS register.)  Probably 
> some IRQs need to be masked before disabling the dss_iclk.

It doesn't seem to be DSS related, the same crash happens also with
cam_ick and sgx_ick.

 Tomi


