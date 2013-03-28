From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH RESEND v2 1/1] usb: musb: implement (un)map_urb_for_dma hooks
Date: Thu, 28 Mar 2013 15:44:50 +0200
Message-ID: <CAB=otbS2C3pmLhuOOHau4=_7G0VBp-Y-aDi3YOpHkq+=YR+x_Q@mail.gmail.com>
References: <1363284729-24228-1-git-send-email-ruslan.bilovol@ti.com>
	<1363284729-24228-2-git-send-email-ruslan.bilovol@ti.com>
	<20130327131711.GG4626@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45853 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab3C1Nov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 09:44:51 -0400
In-Reply-To: <20130327131711.GG4626@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Felipe,

On Wed, Mar 27, 2013 at 3:17 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Mar 14, 2013 at 08:12:09PM +0200, Ruslan Bilovol wrote:
>> MUSB controller cannot work in DMA mode with misaligned buffers,
>> switching in PIO mode.
>>
>> HCD core has hooks that allow to override the default DMA
>> mapping and unmapping routines for host controllers that have
>> special DMA requirements, such as alignment contraints.
>>
>> It is observed that work in PIO mode is slow and it's better
>> to align buffers properly before passing them to MUSB
>>
>> This increased throughput 80->120 MBits/s over musb@omap4 with
>> USB Gigabit ethernet adapter attached.
>>
>> Some ideas taken from ehci-tegra.c
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
>> ---
>>  drivers/usb/musb/musb_core.c |   14 ++++++
>>  drivers/usb/musb/musb_host.c |  102 +++++++++++++++++++++++++++++++++++++++++-
>>  drivers/usb/musb/musb_host.h |    2 +-
>>  3 files changed, 116 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 60b41cc..91ac166 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -1431,6 +1431,20 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
>>
>>       /* log release info */
>>       musb->hwvers = musb_read_hwvers(mbase);
>> +
>> +#ifndef CONFIG_MUSB_PIO_ONLY
>> +     /*
>> +      * The DMA engine in RTL1.8 and above cannot handle
>> +      * DMA addresses that are not aligned to a 4 byte boundary.
>> +      * For such engine implemented (un)map_urb_for_dma hooks.
>> +      * Do not use these hooks for RTL<1.8
>> +      */
>> +     if (musb->hwvers < MUSB_HWVERS_1800) {
>
> if you move this check to map/unmap and always return error if this is
> true, you can avoid removing 'const' from our struct hc_driver. Would
> that work ?

If we return an error in map/unmap callbacks, this will break urb transferring,
however I can call core function usb_hcd_(un)map_urb_for_dma() instead of
returning the error (and that is default behavior if we do not have
map/unmap callbacks
set for the hc driver) so I can avoid removing 'const' from our struct
hc_driver and this will work.
The side effect will be only in small overhead for this path.

So, will be this OK for you? I will send v3 in this case.

-- 
Best regards,
Ruslan Bilvol

>
> --
> balbi
