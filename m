From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm: omap: remove *.auto* from device names given
 in usb_bind_phy
Date: Mon, 9 Dec 2013 12:50:35 +0100
Message-ID: <CABxcv=kYAB5MKtW0O1RLZUXPxiTmoSDD0nuHB=Bjy2gy+wzvhQ@mail.gmail.com>
References: <1386331571-30903-1-git-send-email-kishon@ti.com>
	<1386331571-30903-3-git-send-email-kishon@ti.com>
	<CABxcv=n67gNq6ayx+t_mfZ0++UBKkXpH9avXvRKFEH4VUrwy0g@mail.gmail.com>
	<20131206210835.GM21086@saruman.home>
	<52A55E2C.7070500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52A55E2C.7070500-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On Mon, Dec 9, 2013 at 7:07 AM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
>
> On Saturday 07 December 2013 02:38 AM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> On Fri, Dec 06, 2013 at 01:14:38PM +0100, Javier Martinez Canillas wrote:
>>>
>>> On Fri, Dec 6, 2013 at 1:06 PM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>> wrote:
>>>>
>>>> Previously MUSB wrapper (OMAP) device used PLATFORM_DEVID_AUTO while
>>>> creating
>>>> MUSB core device. So in usb_bind_phy (binds the controller with the
>>>> PHY), the
>>>> device name of the controller had *.auto* in it. Since with using
>>>> PLATFORM_DEVID_AUTO, there is no way to know the exact device name in
>>>> advance,
>>>> the data given in usb_bind_phy became obsolete and usb_get_phy was
>>>> failing.
>>>> So MUSB wrapper was modified not to use PLATFORM_DEVID_AUTO.
>>>> Corresponding
>>>> change is done in board file here.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>   arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
>>>>   arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>>>>   arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
>>>>   arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
>>>>   arch/arm/mach-omap2/board-ldp.c            |    2 +-
>>>>   arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
>>>>   arch/arm/mach-omap2/board-omap3logic.c     |    2 +-
>>>>   arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
>>>>   arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
>>>>   arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
>>>>   arch/arm/mach-omap2/board-overo.c          |    2 +-
>>>>   arch/arm/mach-omap2/board-rx51.c           |    2 +-
>>>>   12 files changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>
>>> You can drop this patch since boards files are being removed for v3.14
>>
>>
>> if we can drop this patch, the whole series is invalid, since we'll be
>> using DT phandles to find PHYs going forward, no ?
>>
> yeah. But in one of the other threads, Tony seemed ok to take a patch that
> fixes the same issue in mach-omap2/twl-common.c. So it's better to confirm
> with Tony.
>

Yes, I just read the other thread ("[PATCH] omap: twl-common: Fix
musb-hdrc device name") and I see that these patches are fixing a
v3.13 regression and are meant for the -rc cycle and not for v3.14.

Sorry for the noise then.

Best regards,
Javier


> Thanks
> Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
