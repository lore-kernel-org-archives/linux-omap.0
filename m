From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] usb: musb: adding nop usb transceiver
Date: Thu, 22 Jan 2009 23:29:07 -0800
Message-ID: <200901222329.07689.david-b@pacbell.net>
References: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:34645 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752021AbZAWH3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 02:29:09 -0500
In-Reply-To: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Thursday 08 January 2009, Ajay Kumar Gupta wrote:
> OP transceiver is used by all the usb transceiver which are mostly
> autonomous and doesn't require any programming or which are built
> into the usb ip itself.NOP transceiver only allocates the memory
> for struct xceiv and calls otg_set_transceiver() so function call
> to otg_get_transceiver() will return a valid ransceiver.
> 
> NOP transceiver device is required to be registered using
> platform_device_register() in platform files.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

We'll need something like this, yes.

This one looks to need a bit of tweaking yet though ...
probably that could be done after merge.  The state can
need changing after one of the drivers is unregistered;
using __exit not __devexit is likely wrong (especially
given your MUSB patchlet); xceiv_to_nop() should be
an inline function; check otg_set_transceiver() value;
don't bother with dev_info(); and I'm not quite sure
of the methods.

Plus I think it's probably best to include a utility
that board init code can call to register the NOP
transceiver device ... instead of cloning that bit of
code (in your second patch) into every board-*.c file
that needs it.

- Dave
