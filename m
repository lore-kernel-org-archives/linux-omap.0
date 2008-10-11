From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Fri, 10 Oct 2008 18:26:07 -0700
Message-ID: <200810101826.07538.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com> <200810101732.31094.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC3560870239624A53@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:46512 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754090AbYJKB0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 21:26:10 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A53@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Friday 10 October 2008, Pandita, Vikram wrote:
> I did not have your following patch.
> Without this patch, the pwrirq does not initialize TWL-USB flag: set_irq_flags(i, IRQF_VALID); 
> And hence the failure. 
> 
> With your patch, you delay the i2c writing and then the set_irq_flags() gets called.

A better fix for this one would be either of the recent i2c-omap patches:
mine disabling the low-power idle mechanism, or Paul's making it actually
work like it was supposed to.  Paul's fix should IMO be merged.

The "MUSB doesn't work on Overo" problem kicks in even with the I2C idle
problem fixed, or that workaround patch.

- Dave
