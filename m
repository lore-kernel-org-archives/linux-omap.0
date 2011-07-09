From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Sat, 9 Jul 2011 19:56:51 +0900
Message-ID: <20110709105649.GA17036@opensource.wolfsonmicro.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
 <20110709012407.GG18860@opensource.wolfsonmicro.com>
 <20110709104007.GM31978@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37487 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750879Ab1GIK47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 06:56:59 -0400
Content-Disposition: inline
In-Reply-To: <20110709104007.GM31978@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com

On Sat, Jul 09, 2011 at 01:40:08PM +0300, Felipe Balbi wrote:

> a hack for a hack... what's the difference ? If it's only to solve a
> limitation temporarily anyways... although it would be better to discuss
> how to add such support to the framework already.

I'm completely unable to identify an issue in the framework that this
patch addresses - the API already supports multiple devices supplying
regulators, it's extremely difficult to understand what motivates the
change.
