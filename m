From: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Fri, 12 May 2017 17:43:21 +0200
Message-ID: <702C7A96-E50D-432D-B243-883D08642093@tecnorama.it>
References: <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908> <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com> <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com> <20170511204406.GI7154@uda0271908>
 <20170511210628.GA3489@atomide.com> <20170512134042.GK7154@uda0271908>
 <20170512145849.GE3489@atomide.com> <20170512152144.GA651@uda0271908>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512152144.GA651@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org



> Il giorno 12 mag 2017, alle ore 17:21, Bin Liu <b-liu@ti.com> ha scritto:
> 
> On Fri, May 12, 2017 at 07:58:49AM -0700, Tony Lindgren wrote:
>> * Bin Liu <b-liu@ti.com> [170512 06:43]:
>>> On Thu, May 11, 2017 at 02:06:28PM -0700, Tony Lindgren wrote:
>>>> 
>>>> Well maybe the minimal fix for now is just pretty much back to
>>>> square one of this thread. This should keep VBUS always on.
>>>> Then we can figure out some logic to cut VBUS later on.
>>>> 
>>>> And yeah, the state machine is really hard to follow so some kind
>>>> of clean up would be nice.
>>> 
>>> Okay, figured out why clearing session in OTG_STATE_A_WAIT_BCON, it is
>>> not for error condition handling (which is done in musb-core), but for
>>> going back to b_idle state from a_host for dual-role mode. otg_timer()
>>> (now is dsps_check_status()) was only called for otg port originally, so
>>> it wasn't an issue, until started calling it for host mode as well when
>>> runtime PM was added.
>> 
>> OK makes sense.
>> 
>>>> 8< -------------------
>>>> --- a/drivers/usb/musb/musb_dsps.c
>>>> +++ b/drivers/usb/musb/musb_dsps.c
>>>> @@ -245,7 +245,6 @@ static int dsps_check_status(struct musb *musb, void *unused)
>>>> 		dsps_mod_timer_optional(glue);
>>>> 		break;
>>>> 	case OTG_STATE_A_WAIT_BCON:
>>>> -		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>>>> 		skip_session = 1;
>>>> 		/* fall */
>>>> 
>>> 
>>> So the above patch breaks otg port when switching from host to device
>>> mode. The following change should solve it. But Tony do you see any way
>>> to improve it with glue->vbus_irq?
>> 
>> OK. No better ideas except I think we should probably have a separate
>> timer for keeping VBUS on after state changes eventually.
> 
> Currently with the patch below, VBUS is constantly on for host-only
> mode, and this is what we want. Why we need a separate timer? No one
> cuts VBUs now for host-only mode.
> 
>> 
>> I guess the real test here would be to connect a USB modem that
>> changes state to the am335x-evm OTG port and make sure it works
>> with commit similar to d680414d0f42 ("ARM: dts: Configure BeagleBone
>> peripheral USB VBUS irq"). And also without configuring the vusb_irq.
> 
> I will test w/ and w/o vbus_irq on BeagleBone.
> 
> Moreno, would you mind to test the patch below with your modem?
> 
> Thanks,
> -Bin.
> 
>> 
>> For the patch below, seems like the way to go for the fix assuming
>> it fixes the $subject issue:
>> 
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> 
>>> 8< --------------------
>>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>>> index 9c7ee26ef388..465281244596 100644
>>> --- a/drivers/usb/musb/musb_dsps.c
>>> +++ b/drivers/usb/musb/musb_dsps.c
>>> @@ -245,9 +245,14 @@ static int dsps_check_status(struct musb *musb, void *unused)
>>>                dsps_mod_timer_optional(glue);
>>>                break;
>>>        case OTG_STATE_A_WAIT_BCON:
>>> +               /* keep VBUS on for host-only mode */
>>> +               if (musb->port_mode == MUSB_PORT_MODE_HOST) {
>>> +                       dsps_mod_timer_optional(glue);
>>> +                       break;
>>> +               }
>>>                musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>>>                skip_session = 1;
>>> -               /* fall */
>>> +               /* fall through */
>>> 
>>>        case OTG_STATE_A_IDLE:
>>>        case OTG_STATE_B_IDLE:

Hello Bin,

today is too late, here.

I’ll try to test it on Monday.

Best regards,

Moreno
