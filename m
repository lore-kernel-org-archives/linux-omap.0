From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
Date: Sun, 7 Oct 2012 09:23:03 +0100
Message-ID: <20121007082303.GD28061@n2100.arm.linux.org.uk>
References: <1349596837.15349.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47716 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2JGIXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 04:23:13 -0400
Content-Disposition: inline
In-Reply-To: <1349596837.15349.2.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Oct 07, 2012 at 04:00:37PM +0800, Axel Lin wrote:
>  config OMAP_DEBUG_LEDS
> -	def_bool y if NEW_LEDS
> +	default y if LEDS_CLASS
>  	depends on OMAP_DEBUG_DEVICES

This change is wrong.  You're making this config entry untyped.
