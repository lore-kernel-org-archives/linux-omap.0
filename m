From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 1/2] ARM: OMAP2+: AM33XX: I2C Sleep/wake sequence support
Date: Wed, 1 May 2013 16:37:56 -0700
Message-ID: <CA+Bv8XYGa0c9+6DawMerDUnZnD_0fEESJZeQLDG6MuJrLPYV0Q@mail.gmail.com>
References: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
	<1367434947-6442-2-git-send-email-Russ.Dill@ti.com>
	<20130501232649.GN28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:34395 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab3EAXh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 19:37:57 -0400
Received: by mail-qc0-f169.google.com with SMTP id p9so18543qca.0
        for <linux-omap@vger.kernel.org>; Wed, 01 May 2013 16:37:56 -0700 (PDT)
In-Reply-To: <20130501232649.GN28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wed, May 1, 2013 at 4:26 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Russ Dill <Russ.Dill@ti.com> [130501 12:07]:
> > This patch adds the ability to write an I2C sleep sequence from
> > SRAM just before WFI, and a wake sequence just after control is passed
> > from the M3. This is useful for adjusting voltages during sleep that cannot
> > be lowered while SDRAM is active.
> >
> > Each sequence is a series of I2C transfers in the form:
> >
> > u8 length | u8 chip address | u8 byte0/reg address | u8 byte 1 | u8 byte n ...
> >
> > The length indicates the number of bytes to transfer, including the register
> > address. The length of the sequence is limited by the amount of space
> > reserved in SRAM, 127 bytes.
> >
> > The sequences are taken from the i2c1 node in the device tree. The property
> > name for the sleep sequence is "sleep_sequence" and the property name for
> > the wake sequence is "wake_sequence". Each property should be an array of
> > bytes.
> >
> > No actions are performed if the properties are not present in the device
> > tree.
>
> Looks like you should make that into just a regular device driver that lives
> under drivers/ somewhere?
>
> Regards,
>
> Tony

This code has to be copied to, and run from SRAM. What would that even
look like? Additionally, there is also code under drivers/ that
manages this piece of hardware, i2c-omap.c. The code in this patch
differs in that it accesses no system memory, no stack, only knows how
to write, and it runs without interrupts.
