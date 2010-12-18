From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: enable smc instruction in new assembler versions
Date: Fri, 17 Dec 2010 17:29:01 -0800
Message-ID: <20101218012901.GG5941@atomide.com>
References: <1291183071-21603-1-git-send-email-john.rigby@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487Ab0LRB3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:29:04 -0500
Content-Disposition: inline
In-Reply-To: <1291183071-21603-1-git-send-email-john.rigby@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Rigby <john.rigby@linaro.org>
Cc: linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

* John Rigby <john.rigby@linaro.org> [101130 21:49]:
> New assemblers need -march=armv7-a+sec on command line or
> .arch_extension sec inline to enable use of the smc instruction.
> 
> This patch uses as-instr to check the latter to conditionally
> enable the former in AFLAGS for files that use smc.
> 
> Checked on both old and new binutils to verify that it does
> not break old versions.

Thanks applying.

Tony
