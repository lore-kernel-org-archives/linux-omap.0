From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Mon, 17 Nov 2008 21:36:44 -0800
Message-ID: <200811172136.45110.david-b@pacbell.net>
References: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com> <20081114214635.GC31944@frodo> <0b7d01c9485e$bca27960$LocalHost@wipultra806>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:45960 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751913AbYKRFgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2008 00:36:47 -0500
In-Reply-To: <0b7d01c9485e$bca27960$LocalHost@wipultra806>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "shekhar, chandra" <x0044955@ti.com>
Cc: me@felipebalbi.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

On Sunday 16 November 2008, shekhar, chandra wrote:
> I had tested twl4030 at 3.4 Mbps couple of months back and it was working fine 
> with current settings. It wasn't a rigorous testing though.

My Beagle booted 2.6.28-rc5-omap with that speed,
and it worked fine too.  No errors even though I'm
using the pmu_stat LED (on a TWL LED) for the MMC
activity indicator ... so it got a decent amount
of traffic.

(Oh, and this is *with* the $SUBJECT patch too.)

- Dave

