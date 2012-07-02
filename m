From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] gpio/omap: cleanups for v3.5
Date: Mon, 02 Jul 2012 10:48:49 -0700
Message-ID: <4FF1DF01.2050308@ti.com>
References: <874nrmtf47.fsf@ti.com> <20120614101541.39f50aee@notabene.brown> <CAC83ZvKT+EDRzBWrMbiyqOYqLW7WudOQeAq5Y5ZgXEs2txEPrA@mail.gmail.com> <20120621131616.7ac6426f@notabene.brown> <CAC83ZvLDObTh2MXABObyGCk5M9qdaJm5GqRUUozFrubH1HfNTg@mail.gmail.com> <20120625161845.59d6330b@notabene.brown> <CAC83ZvJWz7tCL9VSQXiLNoYDrg6+=Mkx7xS9hQivKfA_L_4ANw@mail.gmail.com> <87pq8e6p4e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47300 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932220Ab2GBRsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 13:48:45 -0400
Received: by ggnp1 with SMTP id p1so4693329ggn.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 10:48:43 -0700 (PDT)
In-Reply-To: <87pq8e6p4e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: NeilBrown <neilb@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 07/02/2012 10:37 AM, Kevin Hilman wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Mon, Jun 25, 2012 at 11:48 AM, NeilBrown <neilb@suse.de> wrote:
>>> On Thu, 21 Jun 2012 12:04:26 +0530 "DebBarma, Tarun Kanti"
>>> <tarun.kanti@ti.com> wrote:
>>>
>>>> On Thu, Jun 21, 2012 at 8:46 AM, NeilBrown <neilb@suse.de> wrote:
>>>>> On Thu, 14 Jun 2012 23:24:10 +0530 "DebBarma, Tarun Kanti"
>>>>> <tarun.kanti@ti.com> wrote:
>>>>>
>>>>>> On Thu, Jun 14, 2012 at 5:45 AM, NeilBrown <neilb@suse.de> wrote:
>>>>>>> On Fri, 11 May 2012 17:30:48 -0700 Kevin Hilman <khilman@ti.com> wrote:
>>>>>>>
>>>>>>>> Hi Grant,
>>>>>>>>
>>>>>>>> Here's the final round of GPIO cleanups for v3.5.  This branch is based
>>>>>>>> on my for_3.5/fixes/gpio branch you just pulled.
>>>>>>>>
>>>>>>>> Kevin
>>>>>>>
>>>>>>> Hi.
>>>>>>>
>>>>>>>   I'm not sure if it was this series or the following cleanups which broke
>>>>>>>   things for me, but I've been trying 3.5-rc2 on my GTA04 and the serial
>>>>>>>   console (ttyO2) dies as soon as the omap-gpio driver initialises.
>>>>>>>
>>>>>>>   After some digging I came up with this patch to gpio-omap.c
>>>>>>>
>>>>>>> @@ -1124,6 +1124,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>>>>>>
>>>>>>>         platform_set_drvdata(pdev, bank);
>>>>>>>
>>>>>>> +       if (bank->get_context_loss_count)
>>>>>>> +               bank->context_loss_count =
>>>>>>> +                               bank->get_context_loss_count(bank->dev);
>>>>>>>         pm_runtime_enable(bank->dev);
>>>>>>>         pm_runtime_irq_safe(bank->dev);
>>>>>>>         pm_runtime_get_sync(bank->dev);
>>>>>>>
>>>>>>> which fixes it.
>>>>>>>
>>>>>>> What was happening  was that when omap_gpio_probe calls pm_runtime_get_sync,
>>>>>>> it calls
>>>>>>>   _od_runtime_resume -> pm_generic_runtime_resume -> omap_gpio_runtime_resume
>>>>>>>   -> omap_gpio_restore_context
>>>>>>>
>>>>>>> and then the serial port stops.
>>>>>>> I reasoned that the context probably hadn't been set up yet, so restoring
>>>>>>> from it broke things.
>>>>>>> Initialising bank->context_loss_count seems sensible and would ensure that
>>>>>>> we didn't try to restore the context until it has actually been lost.
>>>>>>
>>>>>> I thought the following code exactly does that. That is context_lost_cnt_after
>>>>>> would be zero until there is context loss. The bank->context_loss_count is zero
>>>>>> at the beginning. So, (context_lost_cnt_after != bank->context_loss_count) would
>>>>>> be false and hence context restore should NOT happen? Not sure if I am
>>>>>> over looking
>>>>>> anything here....
>>>>>>
>>>>>> omap_gpio_runtime_resume(...)
>>>>>> {
>>>>>> ...
>>>>>>          if (bank->get_context_loss_count) {
>>>>>>                  context_lost_cnt_after =
>>>>>>                          bank->get_context_loss_count(bank->dev);
>>>>>>                  if (context_lost_cnt_after != bank->context_loss_count) {
>>>>>>                          omap_gpio_restore_context(bank);
>>>>>>                  } else {
>>>>>>                          spin_unlock_irqrestore(&bank->lock, flags);
>>>>>>                          return 0;
>>>>>>                  }
>>>>>>          }
>>>>>> ...
>>>>>> }
>>>>>
>>>>> Hi,
>>>>>   I've looked more closely at this now.
>>>>>
>>>>> The problem is that the initial context loss count is *not* zero.  Not always.
>>>>> The context loss count is the sum of
>>>>>
>>>>>         count = pwrdm->state_counter[PWRDM_POWER_OFF];
>>>>>         count += pwrdm->ret_logic_off_counter;
>>>>>
>>>>>         for (i = 0; i < pwrdm->banks; i++)
>>>>>                 count += pwrdm->ret_mem_off_counter[i];
>>>>>
>>>>> (from  pwrdm_get_context_loss_count()).
>>>>>
>>>>> These are initlialised in _pwrdm_register
>>>>>
>>>>>         /* Initialize the powerdomain's state counter */
>>>>>         for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
>>>>>                 pwrdm->state_counter[i] = 0;
>>>>>
>>>>>         pwrdm->ret_logic_off_counter = 0;
>>>>>         for (i = 0; i < pwrdm->banks; i++)
>>>>>                 pwrdm->ret_mem_off_counter[i] = 0;
>>>>>
>>>>>         pwrdm_wait_transition(pwrdm);
>>>>>         pwrdm->state = pwrdm_read_pwrst(pwrdm);
>>>>>         pwrdm->state_counter[pwrdm->state] = 1;
>>>>>
>>>>>
>>>>> What I'm seeing is that for wkup_pwrdm and dpll{3,4,5}_pwrdm,
>>>>> the state that pwrdm_read_pwrst returns is PWRDM_POWER_OFF.
>>>>> So that state_counter gets initialised to '1', and so the initial
>>>>> context_loss_count, which includes that counter, is also '1'.
>>>>> I think it is the wkup_pwrdm that covers the GPIOs that are causing problems
>>>>> for me.
>>>> I just put a log in omap_gpio_probe() to see the value of context_loss_count.
>>>> GPIO Bank 0 (WKUP Domain) always shows the count as '1'.
>>>>
>>>> [    0.169494] omap_gpio omap_gpio.0: context_loss_count=1
>>>> [    0.170227] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
>>>> [    0.170471] OMAP GPIO hardware version 0.1
>>>> [    0.170623] omap_gpio omap_gpio.1: context_loss_count=0
>>>> [    0.170928] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
>>>> [    0.171295] omap_gpio omap_gpio.2: context_loss_count=0
>>>> [    0.171600] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
>>>> [    0.171936] omap_gpio omap_gpio.3: context_loss_count=0
>>>> [    0.172241] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
>>>> [    0.172576] omap_gpio omap_gpio.4: context_loss_count=0
>>>> [    0.172882] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
>>>> [    0.173217] omap_gpio omap_gpio.5: context_loss_count=0
>>>> [    0.173522] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
>>>
>>> That's consistent with what I see, and confirm that initialising the
>>> context_lost_count to zero isn't always correct.
>> I am just wondering if the context_lost_count = 1 for GPIO in WKUP domain
>> is expected. In that case we have to add additional logic in runtime callbacks
>> to skip context restore/save for WKUP domain GPIOs.
>> But let's hear what Kevin says.
>
> I think the original patch from Neil looks right.
>
> Note that we would need something like this in the case where we built
> the GPIO driver as a module and it was unloaded/reloaded where the
> starting point of the context-loss count would not be zero.
>
> Neil, care to send a patch w/changelog?
>

Nevermind,  this same issue has come up in another thread with a patch 
proposed.

Kevin
