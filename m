From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] ARM: OMAP: dma.h and legacy code removal
Date: Tue, 18 Jun 2013 00:13:18 -0700
Message-ID: <20130618071318.GB5523@atomide.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11557 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031Ab3FRHNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 03:13:21 -0400
Content-Disposition: inline
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [130615 01:37]:
> Hi
> 
> This set gets rid off arch/arm/mach-omap1/dma.h and
> arch/arm/mach-omap2/dma.h by removing duplicated definitions,
> by using numeric values when setting hwmod and platform data and
> by removing legacy stuff.
> 
> Most cleanup is done by the scripts in commit logs and
> set has been build tested with omap1_defconfig and omap2plus_defconfig.

Thanks applying these into omap-for-v3.11/dma.

Regards,

Tony
