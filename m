From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Sun, 28 Jul 2013 14:37:06 +0000
Message-ID: <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
	<51F4F973.8000303@ahsoftware.de>
	<CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com>
	<51F515A9.9010005@ahsoftware.de>,<CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720Ab3G1Oho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 10:37:44 -0400
In-Reply-To: <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexander Holler <holler@ahsoftware.de>
Cc: ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

(Sorry for the  top posting)

Linus,
Auto request GPIO as an input line when used as IRQ line for DT case has been broken and we did
discuss the issue on couple of threads. Javier's intermediate approach with $subject series was addressing
this long standing issue. But while fixing that case,  unfortunately breaks another case as highlighted
by Alexander. I think the default OMAP DT files will continue to work with these patches applied and
mostly doesn't break anything in default configuration. Ofcourse with the DT modification as done
by Alexander will expose the issue.

So either case we will something broken. I really wanted to have the auto request GPIO supported
when used as IRQ line but surely not at expense of breaking the client drivers. So I am fine 
with whatever you decide.

Regards,
Santosh
________________________________________
From: Linus Walleij [linus.walleij@linaro.org]
Sent: Sunday, July 28, 2013 10:11 AM
To: Alexander Holler
Cc: ext Tony Lindgren; Grant Likely; Shilimkar, Santosh; Kevin Hilman; Javier Martinez Canillas; Jon Hunter; Jean-Christophe PLAGNIOL-VILLARD; Enric Balletbo Serra; Linux-OMAP; Florian Vaussard; Aaro Koskinen; Krishnamoorthy, Balaji T
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT

On Sun, Jul 28, 2013 at 2:59 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 28.07.2013 13:14, schrieb Linus Walleij:

>> What shall we do with this mess now?
(...)
> Hmm, maybe something which adds a mapping for a IRQ when gpio_to_irq()
> is called would help.

I think this bug is pointing back to my initial remark that
we need to flag, in the DT node for each GPIOchip
that provides "auto-IRQs" exactly which IRQ lines that
will be used as simple IRQ lines. This is what I called
"GPIO hogs" a while back.

If this had been done, gpio_request_one() would
*only* have been called on the GPIOs marked as
being used for IRQs simply. And we wouldn't have
had this bug.

I am leaning towards reverting the whole shebang
right now, and using that as an argument to hammer
in my opinion that we need to do it my way unless
something incredibly clever comes up.

Yours,
Linus Walleij
