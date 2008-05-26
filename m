From: "nick loeve" <trickie@gmail.com>
Subject: Re: [PATCH] Fix n800 build - Remove kernel config conditional declaration of TSC2005 device config structures
Date: Mon, 26 May 2008 08:42:34 +0200
Message-ID: <83c2b2e00805252342r27d10902n5b188395e00655b3@mail.gmail.com>
References: <1211705141-12878-1-git-send-email-trickie@gmail.com>
	 <83c2b2e00805250148j54bd3b77sb4740051d293f5dd@mail.gmail.com>
	 <1211718237.22815.118.camel@mort>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:48597 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYEZGmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2008 02:42:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1662592fkq.5
        for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 23:42:40 -0700 (PDT)
In-Reply-To: <1211718237.22815.118.camel@mort>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Igor,

On Sun, May 25, 2008 at 2:23 PM, Igor Stoppa <igor.stoppa@nokia.com> wrote:
> Hi,
>
> On Sun, 2008-05-25 at 10:48 +0200, ext nick loeve wrote:
>> Hi,
>>
>> This patch is if i do not build with CONFIG_TOUCHSCREEN_TSC2005 enabled.
>>
>> I am trying to build a bare basics kernel for the n800,
>
> depending on what exactly is your goal, you might discover that it is
> not reachable: the bootloader does lots of initializations (lcd,
> usb, ...)  that are reset by the respective drivers. In case you don't
> include those drivers, you can kiss goodbye to working power management.

Ok. I was thinking there may be issues similar to that, but for now im
just experimenting. I am also trying to get qemu system emulation
working with a recent linux-omap kernel for the mamona project, which
is how i started on this in the first place.

>
> The only way would be to create a section in the board file which groups
> all the resets and executes them regardless of the respective driver
> being enabled.
>

Hmmm sounds like a challenge :) Ill take a look.

Thanks for the info

Cheers


> The bootrom also does initialize the UART.
>
> --
> Cheers, Igor
>
> ---
>
> Igor Stoppa
> Nokia Devices R&D - Helsinki
>



-- 
Nick Loeve
