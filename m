From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 14/14] OMAP2+: clockdomain: Add an api to read idle mode
Date: Sun, 26 Jun 2011 10:51:41 -0700
Message-ID: <20110626175141.GA2306@google.com>
References: <y>
 <1308913560-333-15-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:33782 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab1FZRvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jun 2011 13:51:50 -0400
Content-Disposition: inline
In-Reply-To: <1308913560-333-15-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 01:06:00PM +0200, Benoit Cousson wrote:
> From: Nayak, Rajendra <rnayak@ti.com>
> 
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
> 
...
> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
> + * @clkdm: struct clockdomain *
> + *
> + * Returns true if the clockdomain is in hardware-supervised
> + * idle mode, or 0 otherwise.
> + *
> + */
> +int clkdm_is_idle(struct clockdomain *clkdm)
...
>  void clkdm_allow_idle(struct clockdomain *clkdm);
>  void clkdm_deny_idle(struct clockdomain *clkdm);
> +int clkdm_is_idle(struct clockdomain *clkdm);

Suggest the new API be named clkdm_allows_idle, since it tests that
hardware-supervised idle is allowed (perhaps via a call to
clkdm_allow_idle), and not that the clock domain is necessarily
idle at the time of call.


Todd
