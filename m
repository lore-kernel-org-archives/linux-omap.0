From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
Date: Thu, 10 Jun 2010 08:56:43 +0300
Message-ID: <20100610055643.GL32208@atomide.com>
References: <1267211687-23551-1-git-send-email-m-sonasath@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
 <20100608100437.GP15515@atomide.com>
 <AANLkTimwvegsWDtS7v-aZmjCHyl46ATcgo5wGWCm3xn-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab0FJF4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 01:56:43 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimwvegsWDtS7v-aZmjCHyl46ATcgo5wGWCm3xn-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Leon Woestenberg <leon.woestenberg@gmail.com> [100609 22:20]:
> Hello Tony,
> 
> On Tue, Jun 8, 2010 at 12:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Because of this, 3630 boards should have the mux register pull-ups disabled,
> > and only use the dedicated I2C pull-ups. In theory external pull-ups should
> > not be needed. The value configured for the dedicated I2C pull-ups depends
> > on the connected I2C device, and the number of devices.
> >
> If the internal pull-ups are disabled, why are external pull-ups not needed?

There are two omap internal pull-ups available: The iopad mux pull-ups and the
I2C specific pull-ups. Only the I2C specific ones should be used.

Regards,

Tony
