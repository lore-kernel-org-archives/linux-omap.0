From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am57xx-beagle-x15: use palmas-usb for
 USB2
Date: Tue, 15 Sep 2015 13:43:04 +0300
Message-ID: <55F7F638.4030205@ti.com>
References: <1438002617-15152-1-git-send-email-rogerq@ti.com>
 <1438002617-15152-3-git-send-email-rogerq@ti.com>
 <20150805103728.GC16878@atomide.com> <55C29DE3.9010108@samsung.com>
 <55E7F86B.7040509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E7F86B.7040509@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 03/09/15 10:36, Roger Quadros wrote:
> Chanwoo,
> 
> On 06/08/15 02:36, Chanwoo Choi wrote:
>> On 08/05/2015 07:37 PM, Tony Lindgren wrote:
>>> * Roger Quadros <rogerq@ti.com> [150727 06:13]:
>>>> The VBUS line of USB2 is connected to VBUS detect logic on
>>>> the PMIC. Use the palmas-usb driver to report VBUS events
>>>> to the USB driver.
>>>>
>>>> As the palmas-usb driver supports GPIO based ID reporting
>>>> provide the GPIO for ID pin as well.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>
>>> This should not cause merge conflicts with what I have queeud
>>> for v4.3, so Chanwoo please feel free to apply with the rest
>>> of the extcon series:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>,
>> I reviewd this patchset related to extcon and give the acked-by message.
>> but patch1 must need the acked-by message from MFD maintainer.
>>
>> If patch1 receive the acked-by message from MFD maintainer,
>> I'll apply it for v4.3.
>>
>> Roger,
>> I think that you better to recevie the acked-by message before v4.2-rc6 release.
>> I have the plan about pull request of extcon for v4.3 after v4.2-rc6 releas.
> 
> Seems like you picked patch 1 but not this one. As Tony has already Acked it
> can you please include patch 2 as well in your tree for -next? Thanks.
> 

Is it possible for you to pick this up for -rc cycle via omap-soc tree?
Thanks.

--
cheers,
-roger
