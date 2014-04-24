From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Thu, 24 Apr 2014 15:34:07 -0700
Message-ID: <7h7g6enyqo.fsf@paris.lan>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
	<CAOCHtYg5_Lvi3SWuWaRTDDNhLJ32jiXsKYQmrsKaShVWpM+xWQ@mail.gmail.com>
	<534D51C1.3010007@ti.com>
	<CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw@mail.gmail.com>
	<20140418225111.GP21823@atomide.com>
	<CAOCHtYjdC-OGkdaBt74xMqi5eDc1eVbU6O7VyWMEYN-U50-Abw@mail.gmail.com>
	<20140418235119.GS21823@atomide.com>
	<20980858CB6D3A4BAE95CA194937D5E73EAC458C@DBDE04.ent.ti.com>
	<20140422140316.GA19317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:40744 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbaDXWeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 18:34:09 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so2398738pad.14
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 15:34:09 -0700 (PDT)
In-Reply-To: <20140422140316.GA19317@atomide.com> (Tony Lindgren's message of
	"Tue, 22 Apr 2014 07:03:16 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Menon, Nishanth" <nm@ti.com>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <bcousson@baylibre.com>

Tony Lindgren <tony@atomide.com> writes:

> * Gupta, Pekon <pekon@ti.com> [140421 23:49]:
>> Tony,
>> 
>> >From: Tony Lindgren
>> >* Robert Nelson <robertcnelson@gmail.com> [140418 16:42]:
>> >> On Fri, Apr 18, 2014 at 5:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Robert Nelson <robertcnelson@gmail.com> [140415 08:46]:
>> >> >>
>> >> >> Background: i also tried getting this having this fixed in u-boot:
>> >> >
>> >> > Do we still need to apply this patch then?
>> >>
>> >> Yeah, Tom want's it done in the kernel:
>> >>
>> >> Here's my proposed u-boot patch:
>> >> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
>> >>
>> >> and Tom's recommendation:
>> >> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html
>> >>
>> >> Once this hits mainline, i'll submit a patch to u-boot to check for
>> >> the presence of this version and drop to the old dtb if not found.
>> >
>> >OK applying into omap-for-v3.15/fixes thanks.
>> >
>> >Tony
>> 
>> You probably missed fixing below typo before applying this patch.
>> omap3-beagle-xm-ab.dts breaks without this.
>
> Yeah pushed out omap-for-v3.15/fixes-v2 with the missing bracket.

Your master branch still has the one that doesn't compile.

Kevin


