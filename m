From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for
 3.13?)
Date: Thu, 13 Feb 2014 14:46:14 -0800
Message-ID: <20140213224613.GC28216@atomide.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
 <52CBB788.9070404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26815 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752192AbaBMWq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:46:26 -0500
Content-Disposition: inline
In-Reply-To: <52CBB788.9070404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rogerq@ti.com, balbi@ti.com

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140107 00:16]:
> Hi Benoit,
> 
> On 12/23/2013 11:28 AM, Peter Ujfalusi wrote:
> > Hi,
> > 
> > The audio frequency has been incorrectly set in the DTS file which results
> > incorrect playback frequency on EVM-SK.
> > 
> > The SD card can not be used without the second patch on 3.13-rc5.
> 
> Can you take a look at these and if it is possible send it for 3.13?

Applying both into omap-for-v3.14/fixes thanks.

Tony
