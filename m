From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/2] ARM: OMAP: dma.h cleanup
Date: Wed, 20 Mar 2013 09:42:45 -0700
Message-ID: <20130320164245.GO16413@atomide.com>
References: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43857 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752066Ab3CTQms (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 12:42:48 -0400
Content-Disposition: inline
In-Reply-To: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [130313 13:20]:
> I don't know is this good or bad idea, thus RFC.
> 
> I got this idea after noticing that McBSP DMA channel definitions are no
> longer used for OMAP2 and EAC DMA channel were never used in upstream.
> Scripts here are used to remove all of those unused ones.
> 
> Build tested with omap1_defconfig and omap2plus_defconfig.

Yeah let's get rid of them. I'll apply these into omap-for-v3.10/cleanup.

Regards,

Tony
