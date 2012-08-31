From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 20/23] OMAPDSS: MANAGER: Update display sysfs store
Date: Fri, 31 Aug 2012 20:11:44 +0530
Message-ID: <5040CD28.8040408@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-21-git-send-email-archit@ti.com> <1346423449.16067.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2HaOla (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:41:30 -0400
In-Reply-To: <1346423449.16067.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 08:00 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> The display sysfs attribute's store function needs to be changed with the
>> introduction of outputs.
>>
>> Providing a manager to the display isn't enough to create a link now, the
>> manager needs and output to connect to. A manager's display store file only
>> has the information of the manager and the desired display, it is not aware
>> of which output should the manager connect to.
>>
>> Because of this, a new constraint needs to be set up when setting a display via
>> this sysfs file. The constraint is that the desired display should already be
>> connected to an output before calling this sysfs function.
>>
>> This might break some existing user space stuff which uses sysfs directly. But
>> in most cases dss_recheck_connections will connect displays to floating outputs.
>> DSS sysfs files are being planned to be remove anyway, so it's not much of a
>> harm.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/manager.c |   25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
>> index fd39f66..d808ce2 100644
>> --- a/drivers/video/omap2/dss/manager.c
>> +++ b/drivers/video/omap2/dss/manager.c
>> @@ -74,18 +74,33 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
>>   	if (dssdev)
>>   		DSSDBG("display %s found\n", dssdev->name);
>>
>> -	if (mgr->get_device(mgr)) {
>> -		r = mgr->unset_device(mgr);
>> +	if (mgr->output) {
>> +		if (mgr->output->device) {
>> +			r = mgr->output->unset_device(mgr->output);
>> +			if (r) {
>> +				goto put_device;
>> +				DSSERR("failed to unset device from output\n");
>> +			}
>> +		}
>> +
>> +		r = mgr->unset_output(mgr);
>>   		if (r) {
>> -			DSSERR("failed to unset display\n");
>> +			DSSERR("failed to unset current output\n");
>>   			goto put_device;
>>   		}
>>   	}
>>
>>   	if (dssdev) {
>> -		r = mgr->set_device(mgr, dssdev);
>> +		struct omap_dss_output *out = dssdev->output;
>> +
>> +		if (!out) {
>> +			DSSERR("no output connected to device\n");
>> +			goto put_device;
>> +		}
>> +
>> +		r = mgr->set_output(mgr, out);
>>   		if (r) {
>> -			DSSERR("failed to set manager\n");
>> +			DSSERR("failed to set manager output\n");
>>   			goto put_device;
>>   		}
>>
>
> Hmm, I think this is a bit broken. If I read this right, the unlinking
> removes both mgr-output link and the output-dssdev link. But the linking
> part only sets up the mgr-output link.
>
> So if there's a very simple configuration with one display, if you
> unlink it via sysfs you can't link it back again.

Ah, right. You might need to reinsert the display module again to get 
the output-display link again. Which is bad. Or have a sysfs file for 
setting manager output. Which is something we want to stay away from anyway.

>
> The store function gets the mgr and the dssdev as arguments. I think
> this could be changed so that the function would "guess" the needed
> output. Well, not so much a guess, because a dssdev can only be
> connected to one output, defined by the HW design. That is basically
> what the recheck_connections does, we could use the same method here.
>
> Then this sysfs file should work just like before.

That's a good idea, we could reuse the code in recheck_connections a 
bit. I wanted to stay away from the guessing. But I think we need to do 
it if a simple unlink-link of a display itself fails.

Archit

