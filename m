From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 3/5] USB: OMAP1: OTG controller driver
Date: Tue, 18 Jun 2013 19:55:56 +0300
Message-ID: <20130618165556.GD3073@blackmetal.musicnaut.iki.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
 <20130618082143.GE5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:54333 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933016Ab3FRQ4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 12:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20130618082143.GE5461@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi,

On Tue, Jun 18, 2013 at 11:21:43AM +0300, Felipe Balbi wrote:
> On Sun, Jun 16, 2013 at 04:35:10PM +0300, Aaro Koskinen wrote:
> > +#include <mach/usb.h>
> 
> no mach/* includes under drivers/usb, sorry. It's a pain to fix those up
> later.

Sorry, that was left there by a mistake. I will fix.

A.
