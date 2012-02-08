From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Wed, 08 Feb 2012 12:52:51 +0100
Message-ID: <4F326213.3030500@atmel.com>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk> <20120124095009.GS16726@n2100.arm.linux.org.uk> <20120126212319.GE11941@n2100.arm.linux.org.uk> <CAOesGMh45HSb4mRMc7q53xhmj_kMFvdVJhNnY7cY6gHi=_KynQ@mail.gmail.com> <4F266C13.5080302@atmel.com> <CAOesGMh1wHpaDmYY6_oCu_u0s4fmTfKMLiPaa9bHh9YaiDJozw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMh1wHpaDmYY6_oCu_u0s4fmTfKMLiPaa9bHh9YaiDJozw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/08/2012 02:18 AM, Olof Johansson :
> Hi,
> 
> On Mon, Jan 30, 2012 at 2:08 AM, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>> On 01/29/2012 12:57 AM, Olof Johansson :
>>> Hi,
>>>
>>>
>>> On Thu, Jan 26, 2012 at 1:23 PM, Russell King - ARM Linux
>>> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>>>
>>>
>>>> And we're now there.  So...
>>>>
>>>> Arnd, Olaf,
>>>>
>>>> Please incorporate the latest ARM (for-armsoc branch) changes, which can be found at:
>>>>
>>>>        git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git for-armsoc
>>>>
>>>> with SHA1 dcf81c1af839b77b44404453ecae6e5ac5a75f05.
>>>
>>> Thanks. I have added this as depends/rmk/for-armsoc in the arm-soc repo.
>>>
>>> Any next/ branch we start will have this as the base of said branch,
>>> so any vendor branches must either already be developed against this
>>> stable branch, or merge on top of this with minimal conflicts.
>>
>> Ok, great.
>>
>> I just let you know that there is a conflict between the current Linus'
>> tree (with recently updated at91 fixes) and this rmk/for-armsoc branch.
>>
>> I can give you the resolution of this conflict easily but I would like
>> to know which way I execute the merge:
>>
>> I use this rmk/for-armsoc as a baseline and merge the fixes already in
>> Linus' tree on top of it or the other way around?
>>
>> Maybe it is preferable that I wait for 3.3-rc2 and merge rmk/for-armsoc
>> on top of it. This result can be the base of our AT91 work for 3.4
>> preparation.
>>
>> Your thought?
> 
> I missed replying to this email until now when I started looking at
> picking up branches for the 3.4 staging, sorry for the delay.
> 
> Russell, would you prefer merging in v3.3-rc2 into your branch so I
> can pull the exact same resolution from there, or should we do it
> locally in arm-soc? It probably makes sense for you to do it so
> there's no more conflicts from there on out for dependent branches.

Olof,

For your information the conflict resolution is already present in
linux-next (and in my 3.4 preparation branches actually).

Best regards,
-- 
Nicolas Ferre
