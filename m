From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 02:19:25 +0100
Message-ID: <CABxcv=kUwU2KVw5jYryh62v5us2-CiJFMnYN2nyWLRMWnEkU3w@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<1425915402-10012-3-git-send-email-eliad@wizery.com>
	<CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:39809 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbCKBT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2015 21:19:26 -0400
Received: by wghn12 with SMTP id n12so5745583wgh.6
        for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2015 18:19:25 -0700 (PDT)
In-Reply-To: <CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

Hello Eliad,

On Wed, Mar 11, 2015 at 1:28 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On Mon, Mar 9, 2015 at 4:36 PM, Eliad Peller <eliad@wizery.com> wrote:
>> --- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
>> @@ -42,4 +42,13 @@
>>         vmmc-supply = <&lbep5clwmc_wlen>;

Something I forgot to mention is that this vmmc-supply is a DT hack
since the WLAN SDIO chip needs a WL_EN signal to be asserted as a part
of the chip power sequencing.

But there wasn't a DT binding to describe that so most boards use the
same hack which is to define a fake fixed-regulator with an enable
GPIO just to toggle that pin.

But now the MMC subsystem has support for power sequence providers and
the pwrseq-simple driver
(Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt) has
support for reset GPIOs so you may want to change that as well.

In fact, the pwrseq-simple also has support for an external clock (and
can be extended to support more than one) so if the clocks are not
internal to the wl12xx, maybe these should be defined in the
pwrseq-simple dev node assuming that there is a clock driver for them.

Best regards,
Javier
