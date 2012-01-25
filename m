From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP3530 vs DM3730
Date: Wed, 25 Jan 2012 05:24:56 -0700
Message-ID: <4F1FF498.4050700@mlbassoc.com>
References: <4F1AE4E6.8090000@mlbassoc.com>  <79CD15C6BA57404B839C016229A409A8317AF070@DBDE01.ent.ti.com>  <4F1D64A1.6020604@mlbassoc.com> <1327489626.1858.34.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:44604 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab2AYMY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 07:24:58 -0500
In-Reply-To: <1327489626.1858.34.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2012-01-25 04:07, Tomi Valkeinen wrote:
> On Mon, 2012-01-23 at 06:46 -0700, Gary Thomas wrote:
>> On 2012-01-22 22:06, Hiremath, Vaibhav wrote:
>>> On Sat, Jan 21, 2012 at 21:46:38, Gary Thomas wrote:
>>>> I'm running the public 3.0 kernel on my boards.  I have some boards
>>>> which can have either OMAP3530 or DM3730 (newer boards have the
>>>> newer part, but everything else is the same).
>>>>
>>>> On the OMAP3530, I can enable the graphics overlay on the TV (S-Video)
>>>> output via the attached script.  On the DM3730 boards, this crashes
>>>> the kernel hard :-(
>>>>
>>> Can you share the kernel crash log here?
>>
>> Sadly, no, as it just locks up tight.  At this point, I can only
>> reset manually.  I've tried sifting through the dmesg log (_log_buf)
>> in U-Boot, but I don't see any tell-tale trace of why it crashes.
>>
>> Further investigation shows that it's not really a problem between 3530 and
>> 3730, sorry.  I thought I had a 3530 system where it worked, but trying it
>> again today, it also fails. It seems to always fail when I enable fb2 as an
>> overlay using the TV as the manager.
>>
>> I know this worked as far back as 2.6.28 and it works again in 3.2. I've
>> isolated where the kernel fails to the function dispc_pclk_rate().  This
>> function is quite different in 3.2 than 3.0, so I back-stitched it like
>> this:
>>
>> unsigned long dispc_pclk_rate(enum omap_channel channel)
>> {
>>           unsigned long r;
>>
>>           if (dispc_mgr_is_lcd(channel)) {
>>                   int pcd;
>>                   u32 l;
>>
>>                   l = dispc_read_reg(DISPC_DIVISORo(channel));
>>                   pcd = FLD_GET(l, 7, 0);
>>                   r = dispc_lclk_rate(channel);
>>
>>                   return r / pcd;
>>           } else {
>>                   unsigned long venc_get_pixel_clock(void);
>>                   return venc_get_pixel_clock();
>>           }
>> }
>
> I think this commit fixes the crash:
> c3dc6a7afb47735b82a4c0061e814454a649dbfc
>
> Your changes above seems to be ok for omap3.
>
>> The kernel no longer crashes hard, but now I get these error messages
>> printed when I enable the overlay:
>>     omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX
>>     omapdss DISPC error: GO bit not down for channel 1
>>     omapdss DISPC error: VID2_FIFO_UNDERFLOW, disabling VID2
>>     omapdss DISPC error: SYNC_LOST_DIGIT, disabling TV
>
> So does everything work if you use the LCD? And the problems only appear
> when you enable the tv-output?
>
> You could try a bit more step-by-step approach in your script. First
> enable GFX overlay on the LCD, and resize it so that it fits to both LCD
> and TV. See that it works ok. Then enable the TV-out. Then move the GFX
> overlay to the TV. etc.
>
> Also, if you have your test setup working on newer kernel, and it
> doesn't work on older, you could get dumps of the dss registers and
> compare those. (debugfs/omapdss/dispc and venc).
>
> Hmm. Actually, your script is missing something: it doesn't set the
> input_size, i.e. the framebuffer size for fb2. You should set it before
> enabling the overlay (fbset -xres $w -vxres $w -yres $h -vyres $h).
>
> I haven't tested tv-out for a while, but I could give it a try on
> BeagleBoard. Although I don't have an s-video cable, but I guess it's
> enough if I don't see the underflows =).

Thanks, I played around with this a bit and found an error in the
script I was running.  I have some systems which have only TV, so
their kernels only expose one display(*).  My other systems have both
LCD and TV.  I was trying the [TV only] script on a system with both
which led to the underflow errors.  When I use the right script on
the right machine, it's working fine.

Sorry for the noise

(*) The choice to expose only valid displays was done to minimize the
possible confusion for our [less sophisticated] users.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
