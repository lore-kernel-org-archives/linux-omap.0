From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH E 10/14] OMAP clock: support "dry run" rate and parent changes
Date: Sun, 8 Feb 2009 11:48:58 -0800
Message-ID: <200902081148.59158.david-b@pacbell.net>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192753.29333.56931.stgit@localhost.localdomain> <20090208131734.GA21434@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:48796 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752851AbZBHTtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 14:49:07 -0500
In-Reply-To: <20090208131734.GA21434@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sunday 08 February 2009, Russell King - ARM Linux wrote:
> A far better way to approach this would be to split the set_rate/recalc
> functionality into two parts:
> 
> 1. a method which returns the both the new clock rate and the hardware
>    programming information
> 2. a method to commit the hardware programming information to the registers

Much simpler to just pass a "commit" flag and not
try to come up with some generic way to represent
"hardware programming information"; in general that
will be very different between clocks.

Then clk_round_rate() passes "false" for commit,
while clk_set_rate() passes "true".  And in both
cases the value returned is the rate, or negative
errno to indicate a fault.

- Dave
