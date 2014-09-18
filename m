From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: arm: fiq: fix build breakage with CONFIG_FIQ
Date: Thu, 18 Sep 2014 14:49:56 +0100
Message-ID: <20140918134956.GG12379@n2100.arm.linux.org.uk>
References: <1410984101-16762-1-git-send-email-balbi@ti.com> <541A193F.2060503@linaro.org> <20140918015127.GA5745@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33493 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754380AbaIRNuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2014 09:50:05 -0400
Content-Disposition: inline
In-Reply-To: <20140918015127.GA5745@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Nicolas Pitre <nico@linaro.org>

On Wed, Sep 17, 2014 at 08:51:28PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Sep 17, 2014 at 04:29:03PM -0700, Daniel Thompson wrote:
> > On 17/09/14 13:01, Felipe Balbi wrote:
> > > commit e1add97 (ARM: 8150/2: fiq: Replace default FIQ handler)
> > > has a typo which causes build breakage whenever CONFIG_FIQ is
> > > set.
> > > 
> > > The bug is very clear as can be noted that a new struct pt_regs
> > > def_fiq_regs was defined but code uses dfl_fiq_regs.
> > 
> > Quite so. My fault.
> > 
> > This error was picked up by Olof's autobuilder and I have offered
> > a fix as 8150/3 (posted to mailing list in this thread
> > http://thread.gmane.org/gmane.linux.kernel/1789554 ).
> 
> aaa, alright. I missed that one :-)
> 
> > Your fix and mine are slightly different (I standardised on
> > dfl_fiq_regs) but both approaches should be functionally identical.
> 
> sure thing, no issues. I reckon it should be in next within the next
> couple days ?

Should be in the next next.  It missed last night's sfr pull.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
