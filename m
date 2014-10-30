From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 05/10] ARM: OMAP2+: Fix support for multiple devices on
 a GPMC chip select
Date: Thu, 30 Oct 2014 14:26:18 +0200
Message-ID: <54522E6A.6060502@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com> <1414628948-30702-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40734 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933483AbaJ3M0o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2014 08:26:44 -0400
In-Reply-To: <1414628948-30702-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> There are cases where we have multiple device instances
> connected to a single GPMC chip select. For example, there
> are four UARTs on the Zoom debug boards that all share a
> single chip select and a GPIO interrupt.
> 
> We do have support for this already in theory, but it's broken
> because we're bailing out if the chip select is already taken.
> 
> To be able to provide checks on the chip select usage, let's
> add new struct gpmc_cs_data so we can start using already
> registered device names for checks.
> 
> Later on we probably want to start using struct gpmc_cs_data
> as a wrapper for all the GPMC chipselect related data.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

