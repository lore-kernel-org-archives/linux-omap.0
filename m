From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 07 Nov 2013 14:32:35 +0100
Message-ID: <527B9673.60400@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com> <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com> <527A7E20.4040107@ti.com> <527B95E3.9060802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:48240 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab3KGNcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 08:32:47 -0500
Received: by mail-bk0-f44.google.com with SMTP id mx11so234822bkb.3
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 05:32:46 -0800 (PST)
In-Reply-To: <527B95E3.9060802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gururaja Hebbar <gururaja.hebbar@ti.com>, joelf@ti.com, Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Matt Porter <matt@ohporter.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

On 11/07/2013 02:30 PM, Gururaja Hebbar wrote:
> On Wednesday 06 November 2013 11:06 PM, Joel Fernandes wrote:
>> Hi Vaibhav,
>>
>> On 10/31/2013 05:25 PM, Vaibhav Bedia wrote:
>>> Hi Daniel,
>>>
>>> On Wed, Oct 30, 2013 at 4:21 PM, Daniel Mack <zonque@gmail.com> wrote:
>>> [...]
>>>> +
>>>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
>>>> +
>>>>  static struct platform_driver edma_driver = {
>>>>         .driver = {
>>>>                 .name   = "edma",
>>>> +               .pm     = &edma_pm_ops,
>>>>                 .of_match_table = edma_of_ids,
>>>>         },
>>>
>>> A while back we discovered a nasty race condition here that had us move the EDMA
>>> PM callbacks to the noirq phase. IIRC the MMC driver was resuming
>>> before the EDMA
>>> driver had a chance to run and that was leading to a deadlock. I am
>>> not sure how to force
>>> this scenario but i do remember spending time debugging this on a
>>> random codebase.
>>> Maybe some else has some better ideas on how to force this race condition...
>>
>> I think you're talking about the patch at [1] which is not upstream. A quick
>> question with my limited knowledge of suspend/resume- How can there be pending
>> I/O operations between suspend/resume cycles? 
> 
> AFAIK, MMC framework started talking to cards immediately after resume.
> Due to race condition, EDMA resume callback had not yet completed and
> HSMMC driver had initiated a DMA operation. This resulted in Deadlock.

Hmm. At least in my case, that doesn't happen. And my debug logs also
show that the calls are in expected order. Which tree were you on when
you saw this?


Thanks,
Daniel

