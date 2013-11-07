From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 15:34:58 -0500
Message-ID: <CANacCWywXesGuA7w0m-iVspUN7u4Y-XCdvmtwgOoyw0irJ+_gA@mail.gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
	<CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>
	<527A7E20.4040107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:56693 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab3KGUe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 15:34:59 -0500
Received: by mail-qc0-f182.google.com with SMTP id n7so911075qcx.41
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 12:34:59 -0800 (PST)
In-Reply-To: <527A7E20.4040107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: joelf@ti.com
Cc: Daniel Mack <zonque@gmail.com>, Matt Porter <matt@ohporter.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Hi Joel,

On Wed, Nov 6, 2013 at 12:36 PM, Joel Fernandes <joelf@ti.com> wrote:
> Hi Vaibhav,
>
> On 10/31/2013 05:25 PM, Vaibhav Bedia wrote:
>> Hi Daniel,
>>
>> On Wed, Oct 30, 2013 at 4:21 PM, Daniel Mack <zonque@gmail.com> wrote:
>> [...]
>>> +
>>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
>>> +
>>>  static struct platform_driver edma_driver = {
>>>         .driver = {
>>>                 .name   = "edma",
>>> +               .pm     = &edma_pm_ops,
>>>                 .of_match_table = edma_of_ids,
>>>         },
>>
>> A while back we discovered a nasty race condition here that had us move the EDMA
>> PM callbacks to the noirq phase. IIRC the MMC driver was resuming
>> before the EDMA
>> driver had a chance to run and that was leading to a deadlock. I am
>> not sure how to force
>> this scenario but i do remember spending time debugging this on a
>> random codebase.
>> Maybe some else has some better ideas on how to force this race condition...
>
> I think you're talking about the patch at [1] which is not upstream. A quick

Yeah that's the one.

> question with my limited knowledge of suspend/resume- How can there be pending
> I/O operations between suspend/resume cycles? The sync is done before suspend,
> so I don't understand how one is receiving a response from the card after resume
> before EDMA can resume? I'd imagine that until all devices are resumed, there
> will be no I/O operation issued. Let me know your thoughts.
>

Sadly the commit message does not capture the details to the level it
should have.

>From what i remember, during the resume operation the driver was waiting for the
response of the first cmd that it sends and that never happened since the driver
was setup to use DMA mode and the EDMA driver hadn't resumed. Ideally such
issues should have been noticed a long time back. One more thing to note is that
the MMC controller on AMx series does not have the internal DMA like OMAPx.
However i am not sure how much that, if at all, plays a role here.

Maybe someone internally still has a copy of the analysis done and you could
try to hunt that down for more details. In case you do it would be
good to have it
mentioned here.

Regards,
Vaibhav
