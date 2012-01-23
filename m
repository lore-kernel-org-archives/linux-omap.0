From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP3530 vs DM3730
Date: Mon, 23 Jan 2012 06:46:09 -0700
Message-ID: <4F1D64A1.6020604@mlbassoc.com>
References: <4F1AE4E6.8090000@mlbassoc.com> <79CD15C6BA57404B839C016229A409A8317AF070@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:38922 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2AWNqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 08:46:11 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317AF070@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2012-01-22 22:06, Hiremath, Vaibhav wrote:
> On Sat, Jan 21, 2012 at 21:46:38, Gary Thomas wrote:
>> I'm running the public 3.0 kernel on my boards.  I have some boards
>> which can have either OMAP3530 or DM3730 (newer boards have the
>> newer part, but everything else is the same).
>>
>> On the OMAP3530, I can enable the graphics overlay on the TV (S-Video)
>> output via the attached script.  On the DM3730 boards, this crashes
>> the kernel hard :-(
>>
> Can you share the kernel crash log here?

Sadly, no, as it just locks up tight.  At this point, I can only
reset manually.  I've tried sifting through the dmesg log (_log_buf)
in U-Boot, but I don't see any tell-tale trace of why it crashes.

Further investigation shows that it's not really a problem between 3530 and
3730, sorry.  I thought I had a 3530 system where it worked, but trying it
again today, it also fails. It seems to always fail when I enable fb2 as an
overlay using the TV as the manager.

I know this worked as far back as 2.6.28 and it works again in 3.2. I've
isolated where the kernel fails to the function dispc_pclk_rate().  This
function is quite different in 3.2 than 3.0, so I back-stitched it like
this:

unsigned long dispc_pclk_rate(enum omap_channel channel)
{
         unsigned long r;

         if (dispc_mgr_is_lcd(channel)) {
                 int pcd;
                 u32 l;

                 l = dispc_read_reg(DISPC_DIVISORo(channel));
                 pcd = FLD_GET(l, 7, 0);
                 r = dispc_lclk_rate(channel);

                 return r / pcd;
         } else {
                 unsigned long venc_get_pixel_clock(void);
                 return venc_get_pixel_clock();
         }
}

The kernel no longer crashes hard, but now I get these error messages
printed when I enable the overlay:
   omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX
   omapdss DISPC error: GO bit not down for channel 1
   omapdss DISPC error: VID2_FIFO_UNDERFLOW, disabling VID2
   omapdss DISPC error: SYNC_LOST_DIGIT, disabling TV

Is there any hope of getting this operation to work in 3.0?

>> This same operation seems to be fixed on the 3.2 (public) kernel, but
>> it's difficult for me to upgrade to that kernel for some other reasons.
>>
>> Does anyone have an idea why this might happen?  where to look to
>> isolate the bug(s)?
>>
>> I tried to back-port the 3.2 DSS code into my 3.0 kernel, but my
>> simple attempt was pretty much a failure...  If I can, I'd like to
>> figure out how to just fix the 3.0 code, rather than the full-scale
>> import of the 3.2 code.
>>
>> Thanks for any ideas/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
