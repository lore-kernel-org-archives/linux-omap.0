From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
Date: Thu, 22 Aug 2013 00:45:24 -0700
Message-ID: <20130822074524.GS7656@atomide.com>
References: <521479B4.8030604@asianux.com>
 <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43244 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab3HVHpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 03:45:30 -0400
Content-Disposition: inline
In-Reply-To: <52147E12.4060401@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Chen Gang <gang.chen@asianux.com> [130821 01:53]:
> Hello Maintainers:
> 
> When build arm with allmodconfig under ubuntu i386 with arm-linux-
> gnueabi-gcc 4.7, as 2.22, it report the errors.
> 
> Please help check, thanks (the related config file in attachment).

It seems that some make flags may need to be specified separately
in some makefiles. See the following for some examples:

$ find arch/arm -name Makefile | xargs grep -i flags

I'm getting different errors though, I'm getting:

arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch

As probably my compiler does not support the cortex-a9 switch,
I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.

Regards,

Tony
