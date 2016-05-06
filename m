From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
Date: Fri, 6 May 2016 17:27:17 -0400
Message-ID: <CABxcv=nqdETAJBpO-akYipuHH6F6vy5wxHX+dOt9=0CKTTkt=Q@mail.gmail.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
	<CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
	<572D0B10.60908@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <572D0B10.60908@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

Hello Enric,

On Fri, May 6, 2016 at 5:22 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi Javier,
>
> On 06/05/16 23:07, Javier Martinez Canillas wrote:
>> Hello Enric,
>>
>> On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>> Fix SD card remove/insert detection by adding the correct card-detect
>>> pin. All IGEP OMAP3 based boards use the same card-detect pin.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>>
>> Shouldn't his be Suggested-by: Ladislav Michl <ladis@linux-mips.org> instead?
>>
>> Or if the patch was originally from Ladis, then he should remain the
>> author with your S-o-B after his.
>>
>
> Well Ladis sent the same patch as I had in my local repository for long
> time, so to be strict the correct is have two authors and two S-o-B. My bad
> is not send the patch before.
>

Got it, then I think is correct to have both S-o-B. Thanks for the
clarification.

Best regards,
Javier
