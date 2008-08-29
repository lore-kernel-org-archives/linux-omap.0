From: David Brownell <david-b@pacbell.net>
Subject: Re: Pin mux utility?
Date: Fri, 29 Aug 2008 10:17:39 -0700
Message-ID: <200808291017.40151.david-b@pacbell.net>
References: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34393 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752234AbYH2RRm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 13:17:42 -0400
In-Reply-To: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 29 August 2008, Steve Sakoman wrote:
> Is anyone aware of a utility to report the state of pin mux settings?
> 
> I'd like to verify that u-boot is setting things up properly.

CONFIG_OMAP_MUX_WARNINGS helps for some definitions of "properly":
when Linux needs one setting, but the boot loader leaves a different
one, you get a warning.  That's usually interpreted as u-boot doing
it wrong, except on devboards where the boot loader can't actually
know about all external hardware that might be hooked up (and how).

- Dave


