From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: kernel oops for 3430sdp
Date: Tue, 7 Oct 2008 23:09:22 +0300
Message-ID: <20081007200921.GI8273@frodo>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <200810071128.52889.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35286 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbYJGUJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 16:09:33 -0400
Content-Disposition: inline
In-Reply-To: <200810071128.52889.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Oct 07, 2008 at 11:28:52AM -0700, David Brownell wrote:
> On Tuesday 07 October 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> > <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> Did you try with the hack I've sent, to work around one problematic
> (and surprisingly reproducible!) i2c-omap timeout?  Appended.
> 
> Given I2C faults, many things blow up rudely ... hardly any I2C
> drivers are written to tolerate transfer errors.  Not entirely
> unreasonably, since such errors are otherwise quite rare.
> 
> 
> I currently suspect there's an issue where the i2c-omap code can
> handle a bunch of requests that group closely together ... or are
> separated by a lot of time ... but there's some middle ground
> where if you wait the "right" amount of time before making the
> next request, it times out instead of working correctly.
> 
> I have no proof behind that theory, but it does seem to match up
> to a few of the observed facts.  Notably that the i2c timeouts
> appear when the only device on that bus is the TWL4030, and the
> drivers make known-to-be-valid requets ... the timeouts started
> to appear only after some trivial changes in init timings, which
> were caused by moving code out of drivers/i2c into directories
> that are more appropriate.

I was debugging the i2c-omap.c today but so far no clue why that i2c
timeout is coming. It's really weird that it only fails on twl4030-usb
(well, actually pwrirq and twl4030-usb fails since it can't
request_irq).

-- 
balbi
