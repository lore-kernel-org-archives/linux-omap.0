From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/2] Two phy-twl4030-usb fixes for unloading the module
Date: Tue, 9 Feb 2016 10:41:59 +0530
Message-ID: <56B9751F.9070100@ti.com>
References: <1448948394-32078-1-git-send-email-tony@atomide.com>
 <20160208195149.GV19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208195149.GV19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 09 February 2016 01:21 AM, Tony Lindgren wrote:
> Hi Kishon,
> 
> * Tony Lindgren <tony@atomide.com> [151130 21:40]:
>> Hi,
>>
>> Here are two fixes for rmmod and PM. These can be merged separately after
>> the review from the MUSB related changes.
> 
> Looks like these two fixes never got merged. Care to merge
> these for v4.5-rc cycle with Cc stable v4.4?
> 
> Without these omap3 PM is blocked as the USB modules can
> never be unloaded.
> 
> I can also merge these via the ARM SoC tree if you ack and have
> no other fixes for the -rc cycle.

merged this to linux-phy now. I have a couple of other fixes for this -rc
cycle. Will send this along with the other fixes.

Thanks
Kishon

> 
> Regards,
> 
> Tony
> 
>> Tony Lindgren (2):
>>   phy: twl4030-usb: Relase usb phy on unload
>>   phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload
>>
>>  drivers/phy/phy-twl4030-usb.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.6.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
