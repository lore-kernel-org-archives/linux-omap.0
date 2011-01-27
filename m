From: Silesh C V <saileshcv@gmail.com>
Subject: Re: mux init with multiple signal paths.
Date: Thu, 27 Jan 2011 15:10:39 +0900
Message-ID: <AANLkTi=FKmsPakD-CT52suTKM6FL6BEWQu8vxdo22gLr@mail.gmail.com>
References: <AANLkTim4hVxEsH3ZkwtEhrhQJ6TP==M5cFZra+oxzrh0@mail.gmail.com>
	<c4a538857557cf1a8a969d99f3140580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49942 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1A0GKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 01:10:40 -0500
Received: by iwn9 with SMTP id 9so1652241iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 22:10:39 -0800 (PST)
In-Reply-To: <c4a538857557cf1a8a969d99f3140580@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Anand,

On Thu, Jan 27, 2011 at 1:40 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> Silesh C V wrote:
>> Hi,
>>
>> What is the best way to mux signals which are available on
>> multiple pins ?
>> For example on omap4, gpio 103 can be muxed on
>>
>> 1.gpmc_ncs6.
>> 2.sdmmc_dat1.
>>
>
> Specify the signal as pad.signal:
> gpmc_ncs6.sdmmc_dat1

Thanks. This works. In my case I had to use sdmmc.dat1.gpio_103 to
configure the pin .

>
> (where, pad is the signal name on mode0, and
> signal is the signal name for the mode you are interested in).
>
>> omap_mux_init_gpio and omap_mux_init_signal on these pins will now
>> return with -EINVAL without modifying the mux register and the pin
>> will be left in the state in which the x-loader/u-boot left it at. So
>> is it true that the mux framework does not support muxing pins which
>> have multiple paths and they have to muxed by accessing the registers
>> directly ? Or am I missing something ?
>>
>
> The technique above works at least with omap_mux_init_signal.
>
> I'm not so sure about omap_mux_init_gpio.

If a gpio is available in multiple pins, you have to use
omap_mux_init_signal to configure the pin as gpio_mux_init_gpio takes
only the gpio number and the value as the input and it returns without
altering the mux setting.

Thanks,
Silesh.
