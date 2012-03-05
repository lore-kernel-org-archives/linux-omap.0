From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: id: Add am33xx SoC type detection
Date: Mon, 5 Mar 2012 15:08:13 -0800
Message-ID: <20120305230812.GO12083@atomide.com>
References: <1329113685-7500-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21062 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab2CEXIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 18:08:14 -0500
Content-Disposition: inline
In-Reply-To: <1329113685-7500-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hvaibhav@ti.com, nsekhar@ti.com

* Afzal Mohammed <afzal@ti.com> [120212 22:00]:
> Determine SoC type, i.e. whether GP or HS
> 
> Note: cpu_is_34xx() is true for am33xx also. Doing
> cpu_is_am33xx() check after cpu_is_34xx() will not
> achieve what we want due to the above reason.
> Hence cpu_is_am33xx() is done before cpu_is_34xx()

Thanks, applying into fixes-non-critical-part2.

Tony
