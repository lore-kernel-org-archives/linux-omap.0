From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030-gpio: Fix getting the value of the TWL4030 GPIO  output pin
Date: Sat, 7 Feb 2009 00:00:48 -0800
Message-ID: <200902070000.49089.david-b@pacbell.net>
References: <4e1455be0902062213o769a4d15ha0c892508839dbad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:20827 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753238AbZBGIAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Feb 2009 03:00:51 -0500
In-Reply-To: <4e1455be0902062213o769a4d15ha0c892508839dbad@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 06 February 2009, Joonyoung Shim wrote:
> If TWL4030 GPIO pin is output, must read the value from REG_GPIODATAOUTx
> register in twl4030_get_gpio_datainout().

Why "must"?  The goal is to return the *actual* value of the pin,
not the intended one.  When an external signal overwhelms the drive
capability of that GPIO -- just a couple mA -- the correct value
to return can't be the value written in the output register.

Plus, this patch won't even link ... you changed the name of the
function at its definition, but not at its use points.

NAK, unless you can show there's a real bug this addresses...

- Dave
