From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Sat, 9 Jul 2011 10:24:09 +0900
Message-ID: <20110709012407.GG18860@opensource.wolfsonmicro.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40243 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750962Ab1GIBYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 21:24:15 -0400
Content-Disposition: inline
In-Reply-To: <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com

On Fri, Jul 08, 2011 at 07:25:32PM +0300, Felipe Balbi wrote:

> isn't this all the same as claiming the regulator but never actually
> using the regulator APIs ? I mean, you could add the regulator, then on
> smartreflex code, regulator_get(), but when it gets to get/set voltage,
> you use the omap_*() functions instead of regulator_*().

That wasn't what I got from the patches but it also sounds like a bad
idea.  Why go around the core code?
