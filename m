From: Ashwin Bihari <abihari@gmail.com>
Subject: Fwd: Naming convention used in mux.c
Date: Thu, 29 Jan 2009 10:48:31 -0500
Message-ID: <1f11a5490901290748n618c2554y729d2fad54060136@mail.gmail.com>
References: <19F8576C6E063C45BE387C64729E739403FA79019A@dbde02.ent.ti.com>
	 <1f11a5490901290745i6791571sdf905d26ba666c64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:63225 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZA2Psc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 10:48:32 -0500
Received: by qyk4 with SMTP id 4so8745205qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2009 07:48:31 -0800 (PST)
In-Reply-To: <1f11a5490901290745i6791571sdf905d26ba666c64@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sending to the list in plain text, argh!

-- Ashwin




---------- Forwarded message ----------
From: Ashwin Bihari <abihari@gmail.com>
Date: Thu, Jan 29, 2009 at 10:45 AM
Subject: Re: Naming convention used in mux.c
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Vaibhav,

I was also confused by that when I began playing with the OMAP and
only found those references to make sense when I looked at the
schematics of the board I'm working on. If you look at the Terminal
Pin documents for your specific OMAP you will see the alphabet and
numbers make sense. But you need to know which alphabet/number
specifically is designated to a particular function and this is
something the hardware engineer would do while connecting the OMAP to
the rest of the peripherals on the board.

Regards

-- Ashwin


On Thu, Jan 29, 2009 at 10:34 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>
> Hi,
>
> Can anybody tell me the meaning of naming convention used in mux.c file, e.g. -
>
> MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
>                OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
>                OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
>
> What the suffix "AH8_" and "J25_" means here? I looked into TRM and could not able to co-relate with any meaningful?
>
> Thanks,
> Vaibhav Hiremath
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
