From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 15/17] remoteproc/omap: report device exceptions and
 trigger recovery
Date: Tue, 12 Nov 2019 10:46:15 +0200
Message-ID: <a88ac4e2-ff00-f1d2-2339-72c3315687e4@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-16-t-kristo@ti.com> <20191112062642.GP3108315@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112062642.GP3108315@builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

On 12/11/2019 08:26, Bjorn Andersson wrote:
> On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> 
>> From: Suman Anna <s-anna@ti.com>
>>
>> The OMAP remote processors send a special mailbox message
>> (RP_MBOX_CRASH) when they crash and detect an internal device
>> exception.
>>
>> Add support to the mailbox handling function upon detection of
>> this special message to report this crash to the remoteproc core.
>> The remoteproc core can trigger a recovery using the prevailing
>> recovery mechanism, already in use for MMU Fault recovery.
>>
>> Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> You're missing a Co-developed-by

Yep, let me fix that.

-Tero

> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/remoteproc/omap_remoteproc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
>> index 8bd415c8fc86..6f797025bb6b 100644
>> --- a/drivers/remoteproc/omap_remoteproc.c
>> +++ b/drivers/remoteproc/omap_remoteproc.c
>> @@ -360,8 +360,12 @@ static void omap_rproc_mbox_callback(struct mbox_client *client, void *data)
>>   
>>   	switch (msg) {
>>   	case RP_MBOX_CRASH:
>> -		/* just log this for now. later, we'll also do recovery */
>> +		/*
>> +		 * remoteproc detected an exception, notify the rproc core.
>> +		 * The remoteproc core will handle the recovery.
>> +		 */
>>   		dev_err(dev, "omap rproc %s crashed\n", name);
>> +		rproc_report_crash(oproc->rproc, RPROC_FATAL_ERROR);
>>   		break;
>>   	case RP_MBOX_ECHO_REPLY:
>>   		dev_info(dev, "received echo reply from %s\n", name);
>> -- 
>> 2.17.1
>>
>> --

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
