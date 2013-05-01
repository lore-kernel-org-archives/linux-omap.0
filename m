From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/2] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed, 1 May 2013 16:26:49 -0700
Message-ID: <20130501232649.GN28721@atomide.com>
References: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
 <1367434947-6442-2-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11112 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756890Ab3EAX0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 19:26:53 -0400
Content-Disposition: inline
In-Reply-To: <1367434947-6442-2-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Russ Dill <Russ.Dill@ti.com> [130501 12:07]:
> This patch adds the ability to write an I2C sleep sequence from
> SRAM just before WFI, and a wake sequence just after control is passed
> from the M3. This is useful for adjusting voltages during sleep that cannot
> be lowered while SDRAM is active.
> 
> Each sequence is a series of I2C transfers in the form:
> 
> u8 length | u8 chip address | u8 byte0/reg address | u8 byte 1 | u8 byte n ...
> 
> The length indicates the number of bytes to transfer, including the register
> address. The length of the sequence is limited by the amount of space
> reserved in SRAM, 127 bytes.
> 
> The sequences are taken from the i2c1 node in the device tree. The property
> name for the sleep sequence is "sleep_sequence" and the property name for
> the wake sequence is "wake_sequence". Each property should be an array of
> bytes.
> 
> No actions are performed if the properties are not present in the device
> tree.

Looks like you should make that into just a regular device driver that lives
under drivers/ somewhere?

Regards,

Tony
