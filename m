From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 2/2] arm: mach-omap2: Kconfig: devkit8000 should select
 needed options
Date: Fri, 17 Dec 2010 14:41:24 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1012171424030.13087@esdhcp041196.research.nokia.com>
References: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com> <1292417352-18082-2-git-send-email-aaro.koskinen@nokia.com> <20101215173709.GB8406@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:26688 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab0LQMmq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 07:42:46 -0500
In-Reply-To: <20101215173709.GB8406@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, 15 Dec 2010, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@nokia.com> [101215 04:48]:
>> It's not possible to compile a kernel for this board without I2C,
>> MFD_SUPPORT and TWL4030_CORE, so those should be selected. This will
>> prevent build errors when trying out different configurations.
>
> This one I'm not so convinced about. We should be able to compile
> support for each board and enable and disable these kind of options
> just fine if CONFIG_ARCH_OMAP2PLUS_TYPICAL is disabled.

So in this case we should move the stuff with special dependencies from
the board file into e.g. board-devkit8000-peripherals, which would be
a kernel module?

A.
