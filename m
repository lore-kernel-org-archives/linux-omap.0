From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power
 state
Date: Mon, 31 Jan 2011 16:14:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com> <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab1AaXOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 18:14:12 -0500
In-Reply-To: <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Hello Santosh,

On Fri, 28 Jan 2011, Santosh Shilimkar wrote:

> On OMAP4, one can explicitly program INACTIVE as the power state of
> the logic area inside the power domain. Techincally PD state programmed
> to ON and if all the clock domains within the PD are idled, is equivalent
> tp PD programmed to INACTIVE and all the clock domains within the PD are
> idled. There won't be any power difference in above two.
> 
> Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
> targeted state and also there is some additional latancy involved
> with PD INACTIVE vs PD ON, it's better to support it as an explcit
> PD state.
> 
> This patch adds the support to allow explicit PD INACTIVE
> programming if supported.

What does the hardware do when the powerdomain is programmed to INACTIVE?  
Does it actually force the clockdomains idle?


- Paul
