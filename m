From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/5] Clockdomain split series
Date: Tue, 25 Jan 2011 00:20:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101250018460.25864@utopia.booyaka.com>
References: <1295360860-26490-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59028 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1AYHUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 02:20:47 -0500
In-Reply-To: <1295360860-26490-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com

Hi Rajendra,

On Tue, 18 Jan 2011, Rajendra Nayak wrote:

> This patch series is an effort to split the clockdomain
> framework into platform independent and platform specific parts
> as was done for the powerdomain framework.
> 
> This certainlly helps remove the various cpu_is_* checks
> which exist today in the framework and makes
> the code more maintainable and readable.
> 
> The series is boot tested on OMAP2430/3430/4430SDP platforms.
> Also on OMAP3430SDP, OFF mode in suspend path is validated
> using the omap3_pm_defconfig.
> 
> This series is based on latest mainline kernel and
> can be found here
> git://gitorious.org/omap-pm/linux.git clockdomain-split-v2

Thanks.  I've queued these five patches, along with your powerdomain 
trivial header file removal fix, for 2.6.39.  They are in the 
'pwrdm_clkdm_a_2.6.39' branch of git://git.pwsan.com/linux-2.6 - the 
branch is currently based on v2.6.38-rc2.


- Paul
