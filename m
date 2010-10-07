From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] ARM: Fix HWCAP_TLS flag for ARM11MPCore/Cortex-A9
Date: Wed, 06 Oct 2010 18:00:04 -0700
Message-ID: <1286413204.22265.149.camel@m0nster>
References: <20101007000022.GD4859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56860 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0JGBAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 21:00:04 -0400
In-Reply-To: <20101007000022.GD4859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org

On Wed, 2010-10-06 at 17:00 -0700, Tony Lindgren wrote:

> -	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> +	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS


Thanks for catching this.. I have no idea how this happened, I must have
somehow been using a pre July 5th kernel when I made the patch.. Maybe a
forgotten bisect or something.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.


