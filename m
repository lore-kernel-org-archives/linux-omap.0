From: Eliad Peller <eliad@wizery.com>
Subject: Re: [PATCH v7 0/6] wlcore: add device-tree support
Date: Tue, 24 Mar 2015 21:24:19 +0200
Message-ID: <CAB3XZEd77u36pcqKfMqfUqusHhnFBMJznqRhSL63Yp91y7BXiQ@mail.gmail.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
	<55114C85.60703@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33471 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbbCXTYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 15:24:20 -0400
In-Reply-To: <55114C85.60703@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nikita Kiryanov <nikita@compulab.co.il>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Javier Martinez Canillas <javier@dowhile0.org>

hi Nikita,

On Tue, Mar 24, 2015 at 1:37 PM, Nikita Kiryanov <nikita@compulab.co.il> wrote:
> Hi Eliad,
>
> On 03/18/2015 06:38 PM, Eliad Peller wrote:
>>
>> Add device-tree support to the wlcore (wl12xx/wl18xx)
>> driver.
>>
>> Update the current users to use the bindings instead
>> of pdata-quirks.
>>
>> Finally, remove the deprecated wl12xx_platform_data
>> struct (along with the da850 board file code that
>> still uses it)
>
>
> Tested-by: Nikita Kiryanov <nikita@compulab.co.il>
> Tested on am437x-gp-evm with WL1835MODCOM8B
>
thanks for testing it!

Eliad.
