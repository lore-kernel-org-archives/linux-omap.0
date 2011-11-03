From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] arm: omap: removed obsolete IRQF_DISABLED
Date: Thu, 3 Nov 2011 15:15:01 -0700
Message-ID: <20111103221501.GD31337@atomide.com>
References: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org>
 <1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60025 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1KCWPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 18:15:08 -0400
Content-Disposition: inline
In-Reply-To: <1318139198-6865-2-git-send-email-michael.opdenacker@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Opdenacker <michael.opdenacker@linaro.org>
Cc: linux@arm.linux.org.uk, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patches@linaro.org

* Michael Opdenacker <michael.opdenacker@linaro.org> [111008 22:13]:
> This flag is a NOOP since 2.6.36

Looks like there's an ARM wide patch to do this with
"[PATCH 03/55] arm: irq: Remove IRQF_DISABLED".

Regards,

Tony
