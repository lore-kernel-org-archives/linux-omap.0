From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 16:59:20 +0300
Message-ID: <52580438.4040002@ti.com>
References: <20131003054104.8941.88857.stgit@localhost> <20131003054221.8941.87801.stgit@localhost> <5256AA7F.8030005@ti.com> <20131010160018.GA29913@atomide.com> <5257BB8C.5080001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5257BB8C.5080001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Prakash Manjunathappa <prakash.pm-l0cyMroinI0@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/11/2013 11:49 AM, Roger Quadros wrote:
> On 10/10/2013 07:00 PM, Tony Lindgren wrote:
>> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [131010 06:32]:
>>>
>>> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
>>> while the system is still running and only the EHCI controller is runtime suspended.
>>>
>>> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
>>> whenever the pad wakeup_enable bit is changed.
>>
>> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
>> pcs_irq_handle() like the comments there suggest? At least for me that keeps
>> the wake-up interrupts continuously running on omap3 instead of just idle modes.
> 
> Yes it is on OMAP3. I haven't tried with pcs_soc->rearm(). I will give it a try and
> let you know.
>>
>> Now on omap4, I've noticed the wake up interrupts are on all the time based on tests
>> with the serial driver.
>>  
>>> I think pcs_irq_set_wake() is where need to control system wakeup behaviour for the irq.
>>> This is where we should be able to change WAKEUP_EN bit of the pad
>>> to enable/disable system wakeup for that pad and also call _reconfigure_io_chain().
>>
>> Well the irq_set_wake() should only be needed for suspend and resume. For runtime PM
>> the wake-events should be always enabled by default as pointed out by Alan Stern
>> a while back.
> 
> Right, but we need to update the WAKEUP_EN bit in the pad control register for that
> to work, no?. This is something we are not doing in the driver.

OK sorry, just figured out that we are doing it indeed in pcs_irq_set().
Wasn't able to test it yet with USB. But I don't see any issues except that
pcs_soc->rearm() needs to be called from pcs_irq_set() instead of from pcs_irq_unmask().

After that you can add my

Reviewed-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
