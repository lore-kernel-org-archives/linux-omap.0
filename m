From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3] ARM: OMAP2+: cpu: Add am33xx device under
 cpu_class_is_omap2
Date: Wed, 8 Aug 2012 07:24:54 -0700
Message-ID: <20120808142453.GI11011@atomide.com>
References: <1344348841-19868-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27351 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab2HHOYz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 10:24:55 -0400
Content-Disposition: inline
In-Reply-To: <1344348841-19868-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120807 07:15]:
> AM33XX device falls under omap2 class, so make cpu_class_is_omap2()
> macro true by adding soc_is_am33xx() to existing list of cpu/soc
> check.
> This is required to unblock the basic boot support on AM335x platform.
> 
> Having done that, we still need to sort out properly from
> common zImage point of view without having to maintain this
> cpu/soc_is_xxx list.

Thanks applying into fixes.

Tony
