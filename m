From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] arm: make FORCE_MAX_ZONEORDER configurable for TI
	AM33XX
Date: Tue, 25 Sep 2012 09:32:45 +0100
Message-ID: <20120925083245.GH31374@n2100.arm.linux.org.uk>
References: <1348561590-13361-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39693 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2IYIcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 04:32:50 -0400
Content-Disposition: inline
In-Reply-To: <1348561590-13361-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-omap@vger.kernel.org, Dejan Gacnik <dejan.gacnik@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Sep 25, 2012 at 10:26:30AM +0200, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
> of consistent DMA memory (da8xx frame buffer driver).

Okay, so the patch description says "This needs to be 12 on this platform".

>  config FORCE_MAX_ZONEORDER
> -	int "Maximum zone order" if ARCH_SHMOBILE
> -	range 11 64 if ARCH_SHMOBILE
> +	int "Maximum zone order" if ARCH_SHMOBILE || SOC_AM33XX
> +	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX

but you leave it up to the user to select something that may not be
suitable.  Wouldn't _just_ adding:

	default "12" if SOC_AM33XX

after the "range", and making no other changes be good enough and match
what the patch description says?
