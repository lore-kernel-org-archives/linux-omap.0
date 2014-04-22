From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Tue, 22 Apr 2014 06:49:34 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAC458C@DBDE04.ent.ti.com>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
 <CAOCHtYg5_Lvi3SWuWaRTDDNhLJ32jiXsKYQmrsKaShVWpM+xWQ@mail.gmail.com>
 <534D51C1.3010007@ti.com>
 <CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw@mail.gmail.com>
 <20140418225111.GP21823@atomide.com>
 <CAOCHtYjdC-OGkdaBt74xMqi5eDc1eVbU6O7VyWMEYN-U50-Abw@mail.gmail.com>
 <20140418235119.GS21823@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194AbaDVGuF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 02:50:05 -0400
In-Reply-To: <20140418235119.GS21823@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <bcousson@baylibre.com>

Tony,

>From: Tony Lindgren
>* Robert Nelson <robertcnelson@gmail.com> [140418 16:42]:
>> On Fri, Apr 18, 2014 at 5:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Robert Nelson <robertcnelson@gmail.com> [140415 08:46]:
>> >>
>> >> Background: i also tried getting this having this fixed in u-boot:
>> >
>> > Do we still need to apply this patch then?
>>
>> Yeah, Tom want's it done in the kernel:
>>
>> Here's my proposed u-boot patch:
>> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
>>
>> and Tom's recommendation:
>> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html
>>
>> Once this hits mainline, i'll submit a patch to u-boot to check for
>> the presence of this version and drop to the old dtb if not found.
>
>OK applying into omap-for-v3.15/fixes thanks.
>
>Tony

You probably missed fixing below typo before applying this patch.
omap3-beagle-xm-ab.dts breaks without this.

> +/ {
> +       /* HS USB Port 2 Power enable was inverted with the xM C */
> +       hsusb2_power: hsusb2_power_reg {
> +               enable-active-high;
       };
> +};


with regards, pekon
