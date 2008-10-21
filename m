From: David Brownell <david-b@pacbell.net>
Subject: Re: Fwd: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Mon, 20 Oct 2008 17:14:49 -0700
Message-ID: <200810201714.49979.david-b@pacbell.net>
References: <200810181213.18616.david-b@pacbell.net> <200810201551.39189.david-b@pacbell.net> <20081020231554.GB4833@localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44716 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752534AbYJUAOw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 20:14:52 -0400
In-Reply-To: <20081020231554.GB4833@localdomain>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: linux-omap@vger.kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Monday 20 October 2008, Samuel Ortiz wrote:
> You mean the NR_IRQS reference from the twl4030 irq update patch ?
> I just applied it to my mfd tree, which is built on top of Linus latest git,
> and it seemed to at least build fine.

Yeah, that one.  Evidently prep for some new "sparse IRQs"
infrastructure, which ought to help shrink the 400+ irq_desc
structs on OMAP ... over 400, mostly unused.

If it builds, I'm expecting that when the sparse stuff merges,
that NR_IRQS will morph to nr_irqs.  ;)


> I'm planning to send the last mfd pull request tomorrow, so if you have some
> additional fixes, please send them by then.

None from me.  Thanks for getting this into 2.6.28-rc ...
seems like this wiill be a good base to merge other "child"
drivers (like the USB transceiver) and support for the
high speed MMC/SD driver.

- Dave
 


