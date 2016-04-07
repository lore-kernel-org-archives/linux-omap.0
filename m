From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/4] mailbox/omap: store mailbox interrupt type in
 omap_mbox_device
Date: Thu, 7 Apr 2016 07:24:48 -0500
Message-ID: <57065190.4050904@ti.com>
References: <1459985840-1106-1-git-send-email-s-anna@ti.com>
 <1459985840-1106-2-git-send-email-s-anna@ti.com> <57063731.9010201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57063731.9010201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On 04/07/2016 05:32 AM, Grygorii Strashko wrote:
> On 04/07/2016 02:37 AM, Suman Anna wrote:
>> The interrupt type used for identifying the layout of the interrupt
>> configuration registers between OMAP4+ SoCs and older SoCs is stored
>> only in the sub-mailbox structures for easier access. Store this type
>> in the the omap_mbox_device structure as well along with the other
>> global variables. This is being done to facilitate the context save
>> and restore of appropriate registers during system suspend/resume.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/mailbox/omap-mailbox.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mailbox/omap-mailbox.c
>> b/drivers/mailbox/omap-mailbox.c
>> index 84cafc02e761..adf37f494690 100644
>> --- a/drivers/mailbox/omap-mailbox.c
>> +++ b/drivers/mailbox/omap-mailbox.c
>> @@ -90,6 +90,7 @@ struct omap_mbox_device {
>>       void __iomem *mbox_base;
>>       u32 num_users;
>>       u32 num_fifos;
>> +    u32 intr_type;
>>       struct omap_mbox **mboxes;
>>       struct mbox_controller controller;
>>       struct list_head elem;
>> @@ -828,6 +829,7 @@ static int omap_mbox_probe(struct platform_device
>> *pdev)
>>       mdev->dev = &pdev->dev;
>>       mdev->num_users = num_users;
>>       mdev->num_fifos = num_fifos;
>> +    mdev->intr_type = intr_type;
>>       mdev->mboxes = list;
>>
>>       /* OMAP does not have a Tx-Done IRQ, but rather a Tx-Ready IRQ */
>>
> 
> This smth. which definitely has to be done using compatible props.
> Why not to pass more info through of_device_id->data?
> 

Yeah, that's already the case, intr_type is a local variable assigned
from compatible match data. This patch merely caches it in the
omap_mbox_device structure so that it can be leveraged by the PM
callback functions in the next patch.

regards
Suman
