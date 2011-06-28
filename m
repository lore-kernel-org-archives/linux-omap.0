From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v3 6/8] OMAP2+: clockdomain: Add 2 APIs to control
 clockdomain from hwmod framework
Date: Mon, 27 Jun 2011 18:08:30 -0700
Message-ID: <20110628010830.GA22263@google.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
 <1309191103-8817-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:7866 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab1F1BIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 21:08:35 -0400
Content-Disposition: inline
In-Reply-To: <1309191103-8817-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Mon, Jun 27, 2011 at 06:11:41PM +0200, Benoit Cousson wrote:
...
> + * clkdm_hwmod_disable - remove an enabled downstream hwmod from this clkdm
> + * @clkdm: struct clockdomain *
> + * @oh: struct omap_hwmod * of the disabled downstream hwmod
> + *
> + * Decrement the usecount of this clockdomain @clkdm when @oh is
> + * disabled. Intended to be called by module_disable() code.
> + * If the clockdomain usecount goes to 0, put the clockdomain to sleep
> + * (software-supervised mode) or remove the clkdm autodependencies
> + * (hardware-supervised mode).
> + * Returns -EINVAL if passed null pointers; -ERANGE if the @clkdm usecount
> + * underflows and debugging is enabled; or returns 0 upon success or if the

Can take out "and debugging is enabled", this is no longer the case.


Todd
