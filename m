From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Fri, 13 Dec 2013 17:26:22 +0530
Message-ID: <52AAF5E6.1050900@ti.com>
References: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>	<529D9D43.6040101@ti.com>	<CAAfyv37Vie1vZK2XQ1cfVq6eVnSuaBLfykk6pU8fwEyqvPF4BA@mail.gmail.com>	<CAAfyv35gVVNydrk8vifSyidpFjEXjGiT4-i2dgN5Un2=FuHaqQ@mail.gmail.com>	<20131205184323.GF26766@atomide.com>	<CAAfyv37e9+OLH-KegPCEhc0sbBS7UVnaSGU0mBw2AxAN9D7Akw@mail.gmail.com>	<20131209175006.GD12527@atomide.com> <CAAfyv36P7DDcdaLWtXnZXPfQWPL20shE3kOHWtD0mSmH7aixdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfyv36P7DDcdaLWtXnZXPfQWPL20shE3kOHWtD0mSmH7aixdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 13 December 2013 04:57 PM, Belisko Marek wrote:
> On Mon, Dec 9, 2013 at 6:50 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Belisko Marek <marek.belisko@gmail.com> [131208 23:36]:
>>> Hi Tony,
>>>
>>> On Thu, Dec 5, 2013 at 7:43 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> * Belisko Marek <marek.belisko@gmail.com> [131203 01:21]:
>>>>> On Tue, Dec 3, 2013 at 10:08 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, Dec 3, 2013 at 9:58 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tuesday 03 December 2013 02:03 PM, Marek Belisko wrote:
>>>>>>>> Without this change when booting omap3 device (gta04) with board file
>>>>>>>> leads to follwing errors:
>>>>>>>>
>>>>>>>> [    1.203308] musb-hdrc musb-hdrc.0.auto: unable to find phy
>>>>>>>> [    1.209075] HS USB OTG: no transceiver configured
>>>>>>>> [    1.214019] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
>>>>>>>>
>>>>>>>> and usb isn't working.
>>>>>>>>
>>>>>>>> This is probably regression caused by commit: 6c27f939
>>>>>>>
>>>>>>> I think a better fix would be to have this merged..
>>>>>>> https://lkml.org/lkml/2013/7/26/91
>>>>>> Yes I see but how this could help with current situation? Ho you then
>>>>>> specify device number?
>>>>> I was too fast with reply sorry. I can see whole series and it is of
>>>>> course correct solution. But as I said
>>>>> can we except to be merged to 3.13. If not Tony can you pick my patch.
>>>>
>>>> If it's a regression, then let's get it merged for the -rc cycle.
>>> Yes it is regression and without that usb on most omap3 based boards
>>> without DT will not work.
>>>>
>>>> So please try to follow up on getting the proper fix merged, meanwhile
>>>> I'll mark this thread as read. If you need this one merged for some
>>>> reason, then please report to get it back to my radar.
>>
>> I'm still clueless which USB regression fix to apply for the -rc cycle
>> though.. Hoping to see a single patch which clearly states the issue
>> and has acks.
> Kishon can you please comment on that? Would be possible to get your
> patch to 3.13 (I seen some comments from Felipe).

I'm not sure as my patch modifies all the board files. There was initially some
confusion w.r.t when the board files will be dropped. But since board files
will still be there in 3.13, I'd recommend my patch  [1] to be taken. Anyways
if you have tested my patch (series), pls give your Tested-by.

Tony, summary of the issue..
After the platform devices are created using PLATFORM_DEVID_AUTO, the
device names given in usb_bind_phy (in board file) does not match with
the actual device name causing the USB PHY library not to return the
PHY reference when the MUSB controller request for the PHY in the non-dt boot
case. So removed creating platform devices using PLATFORM_DEVID_AUTO in
omap2430.c. So had to make the corresponding changes in board files.

[1] -> http://lists.scusting.com/index.php?t=msg&th=375579&start=0&S=Google

Thanks
Kishon

> Otherwise I think only possible option to avoid non-working usb in
> 3.13 for omap is took my patch. Thanks.
>>
>> Regards,
>>
>> Tony
> 
> BR,
> 
> marek
> 
