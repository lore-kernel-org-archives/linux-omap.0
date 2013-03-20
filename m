From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Serial driver sysc cleanup for 3.10
Date: Wed, 20 Mar 2013 14:08:44 +0530
Message-ID: <51497594.6080808@ti.com>
References: <1363768601-17862-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58057 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab3CTIgy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 04:36:54 -0400
In-Reply-To: <1363768601-17862-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 20 March 2013 02:06 PM, Santosh Shilimkar wrote:
> Tony,
> 
> Here is the pull request for OMAP serial driver sysconfig cleanup. The series
> removes all the hackery of sysconfig from UART driver and let runtime backend
> handle it. Without this series serial console is almost un-usable on OMAP5.
> One of the patch touches driver/serial but I got an ack from Greg KH to get
> it queued via OMAP tree.
> 
Sent same email couple of more times. Sorry for noise.

Regards
Santosh

