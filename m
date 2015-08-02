From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH v2 0/7] uio_pruss cleanup and platform support
Date: Sun, 2 Aug 2015 21:42:18 +0300
Message-ID: <CAJs94EZAEmab8K=sxtBFu4+86XFmS9UfbvafUFSiZaf5ecoqEg@mail.gmail.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com> <20121003150058.GB11180@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121003150058.GB11180@beef>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>, mporter@konsulko.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2012-10-03 19:00 GMT+04:00 Matt Porter <mporter@ti.com>:
> On Fri, Sep 28, 2012 at 03:37:45PM -0400, Matt Porter wrote:
>> Changes since v1:
>>       - Replaced uio_pruss private SRAM API use with genalloc
>>       - Added DA850 platform device and clock support
>>       - Added DA850 L3 RAM gen_pool support
>>       - Split out DT binding
>>
>> This series enables uio_pruss on both DA850 and AM33xx. The driver
>> previously was not enabled by any platform and the private SRAM API
>> was accessing an invalid SRAM bank for use on DA850. For AM33xx,
>> DT, pinctrl, and runtime PM support are added since AM33xx only
>> boots via DT.
>
> I'm dropping AM33xx/OMAP support from v3 for this series since the
> focus has turned to fixing Davinci SRAM to provide genalloc support
> and the associated use of that in the driver.
>
> I'll have a separate series with AM33xx support since dealing cleanly
> with external resets on OMAP is a bigger issue.

Hello Matt,

Any news on AM33xx support here?

I would even try to implement it by myself, but at the moment stuff
about external resets is too complicated to me, I even can not
understand where problem is. Fetching config from DT instead of
platform in pruss_probe seems to be trivial.

>
> -Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



-- 
With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp://0x2207@jabber.ru
