From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP gpio handling
Date: Sat, 25 Feb 2012 13:04:45 +0000
Message-ID: <20120225130444.GJ22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36850 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2BYNEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Feb 2012 08:04:50 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42438)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1S1HIs-0006pV-KZ
	for linux-omap@vger.kernel.org; Sat, 25 Feb 2012 13:04:47 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1S1HIr-00015K-Bt
	for linux-omap@vger.kernel.org; Sat, 25 Feb 2012 13:04:45 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Can someone explain to me this:

#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))

static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
{
        void __iomem *reg = bank->base + bank->regs->datain;

        return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
}

static int gpio_get(struct gpio_chip *chip, unsigned offset)
{
        struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
        void __iomem *reg = bank->base;
        int gpio = chip->base + offset;
        u32 mask = GPIO_BIT(bank, gpio);

        if (gpio_is_input(bank, mask))
                return _get_gpio_datain(bank, gpio);
        else
                return _get_gpio_dataout(bank, gpio);
}

Given that bank->width on OMAP is either 32 or 16, and GPIO numbers for
any GPIO chip are always aligned to 32 or 16, why does this code bother
adding the chips base gpio number and then modulo the width?

Surely this means if - for argument sake - you registered a GPIO chip
with 8 lines followed by one with 16 lines, GPIO0..7 would be chip 0
bit 0..7, GPIO8..15 would be chip 1 bit 8..15, GPIO16..23 would be
chip 1 bit 0..7.

However, if you registered a GPIO chip with 16 lines first, it would
mean GPIO0..15 would be chip 0 bit 0..15, and GPIO16..31 would be
chip 1 bit 0..15.

Surely this kind of behaviour is not intended?

Is there a reason why the bitmask can't just be (1 << offset) where
offset is passed into these functions as GPIO number - chip->base ?
