From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Suggestion] ARM: allmodconfig: about cross compiling failure
	under i386 ubuntu.
Date: Thu, 22 Aug 2013 11:22:10 +0100
Message-ID: <20130822102210.GF25647@n2100.arm.linux.org.uk>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42410 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab3HVKWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 06:22:25 -0400
Content-Disposition: inline
In-Reply-To: <20130822074524.GS7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 22, 2013 at 12:45:24AM -0700, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130821 01:53]:
> > Hello Maintainers:
> > 
> > When build arm with allmodconfig under ubuntu i386 with arm-linux-
> > gnueabi-gcc 4.7, as 2.22, it report the errors.
> > 
> > Please help check, thanks (the related config file in attachment).
> 
> It seems that some make flags may need to be specified separately
> in some makefiles. See the following for some examples:
> 
> $ find arch/arm -name Makefile | xargs grep -i flags
> 
> I'm getting different errors though, I'm getting:
> 
> arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch
> 
> As probably my compiler does not support the cortex-a9 switch,
> I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.

The use of -mcpu with -march is not a good idea anyway - you either use
-mcpu= or you use -march and -mtune.

-mcpu= sets the CPU type, which specifies the instruction architecture
(iow, which instructions can be used) and instruction scheduling behaviour.

-march= sets the architecture only.  -mtune= sets the instruction
scheduling behaviour only.

So, that -mcpu= should probably be -mtune=, but if that fails due to
unrecognised instructions, the -march= parameter is wrong.

Even so, if gcc 4.3.5 doesn't support cortex-a9 as a CPU type, and we
want to support that gcc version, the setting of -mtune needs to be
conditionalised.  As it is only a scheduling hint, it's probably fine
for it to end up being omitted.
