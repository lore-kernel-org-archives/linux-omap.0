From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 09:18:59 -0600
Message-ID: <527BAF63.10308@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com> <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com> <527A7E20.4040107@ti.com> <527B95E3.9060802@ti.com> <527B9673.60400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3KGPUW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Nov 2013 10:20:22 -0500
In-Reply-To: <527B9673.60400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, joelf@ti.com, Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Matt Porter <matt@ohporter.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 11/07/2013 07:32 AM, Daniel Mack wrote:
> On 11/07/2013 02:30 PM, Gururaja Hebbar wrote:
>> On Wednesday 06 November 2013 11:06 PM, Joel Fernandes wrote:
>>> Hi Vaibhav,
>>>
>>> On 10/31/2013 05:25 PM, Vaibhav Bedia wrote:
>>>> Hi Daniel,
>>>>
>>>> On Wed, Oct 30, 2013 at 4:21 PM, Daniel Mack <zonque@gmail.com> wrote:
>>>> [...]
>>>>> +
>>>>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
>>>>> +
>>>>>  static struct platform_driver edma_driver = {
>>>>>         .driver = {
>>>>>                 .name   = "edma",
>>>>> +               .pm     = &edma_pm_ops,
>>>>>                 .of_match_table = edma_of_ids,
>>>>>         },
>>>>
>>>> A while back we discovered a nasty race condition here that had us move the EDMA
>>>> PM callbacks to the noirq phase. IIRC the MMC driver was resuming
>>>> before the EDMA
>>>> driver had a chance to run and that was leading to a deadlock. I am
>>>> not sure how to force
>>>> this scenario but i do remember spending time debugging this on a
>>>> random codebase.
>>>> Maybe some else has some better ideas on how to force this race condition...
>>>
>>> I think you're talking about the patch at [1] which is not upstream. A quick
>>> question with my limited knowledge of suspend/resume- How can there be pending
>>> I/O operations between suspend/resume cycles? 
>>
>> AFAIK, MMC framework started talking to cards immediately after resume.
>> Due to race condition, EDMA resume callback had not yet completed and
>> HSMMC driver had initiated a DMA operation. This resulted in Deadlock.
> 
> Hmm. At least in my case, that doesn't happen. And my debug logs also
> show that the calls are in expected order. Which tree were you on when
> you saw this?

Tested this on a vendor V3.12 tag based kernel:

Test patch: http://pastebin.com/AmnktQ7B
test: echo -n "1">/sys/power/pm_print_times; rtcwake -d /dev/rtc0 -m
mem -s 5


with the current patch: http://pastebin.com/RujarRLV
suspend_late and resume_early: http://pastebin.com/RujarRLV
suspend_noirq and resume_noirq: http://pastebin.com/nKfbm7Mj

one needs to be careful of the sequence - donot forget that
omap_device also does stuff in the background to every SoC device in
noirq - sequence is paramount. you would want to ensure edma is saving
after every single dependent device is done with it's stuff and
guarenteed to never request any further transaction, and resume is
done before any of the dependent devices need edma. but edma is also a
peripheral that omap_device and generic runtime pm framework deals
with - so ensure sequences consider that as well.

-- 
Regards,
Nishanth Menon
