From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 10/11] usb: otg: Add dual-role device (DRD) support
Date: Fri, 17 Jul 2015 13:47:12 +0300
Message-ID: <55A8DD30.5030407@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-11-git-send-email-rogerq@ti.com> <20150717090212.GC4515@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150717090212.GC4515@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 17/07/15 12:02, Li Jun wrote:
> On Wed, Jul 08, 2015 at 01:19:36PM +0300, Roger Quadros wrote:
> 
> [...]
> 
>>  struct otg_fsm *usb_otg_register(struct device *parent_dev,
>> -				 struct otg_fsm_ops *fsm_ops)
>> +				 struct otg_fsm_ops *fsm_ops,
>> +				 bool drd_only)
>>  {
>>  	struct otg_data *otgd;
>>  	int ret = 0;
>> @@ -328,7 +482,15 @@ struct otg_fsm *usb_otg_register(struct device *parent_dev,
>>  		goto err_wq;
>>  	}
>>  
>> -	usb_otg_init_timers(otgd);
>> +	otgd->drd_only = drd_only;
>> +	/* For DRD mode we don't need OTG timers */
>> +	if (!drd_only) {
>> +		usb_otg_init_timers(otgd);
>> +
>> +		/* FIXME: we ignore caller's timer ops */
>> +		otgd->fsm_ops.add_timer = usb_otg_add_timer;
>> +		otgd->fsm_ops.del_timer = usb_otg_del_timer;
>> +	}
>>  
>>  	/* save original start host/gadget ops */
>>  	otgd->start_host = fsm_ops->start_host;
>> @@ -338,9 +500,6 @@ struct otg_fsm *usb_otg_register(struct device *parent_dev,
> 
> Your above override will be override back to be fsm_ops's by below copy:
> 
> 	/* create copy of original ops */
> 	otgd->fsm_ops = *fsm_ops;
> 
> So add/del_timer must be override after the copy.

Good catch :).

> 
>>  	/* override ops */
>>  	otgd->fsm_ops.start_host = usb_otg_start_host;
>>  	otgd->fsm_ops.start_gadget = usb_otg_start_gadget;
>> -	/* FIXME: we ignore caller's timer ops */
>> -	otgd->fsm_ops.add_timer = usb_otg_add_timer;
>> -	otgd->fsm_ops.del_timer = usb_otg_del_timer;
>>  	/* set otg ops */
>>  	otgd->fsm.ops = &otgd->fsm_ops;
>>  	otgd->fsm.otg = &otgd->otg;
>> @@ -443,8 +602,10 @@ static void usb_otg_stop_fsm(struct otg_fsm *fsm)
>>  	otgd->fsm_running = false;
>>  
>>  	/* Stop state machine / timers */
>> -	for (i = 0; i < ARRAY_SIZE(otgd->timers); i++)
>> -		hrtimer_cancel(&otgd->timers[i].timer);
>> +	if (!otgd->drd_only) {
>> +		for (i = 0; i < ARRAY_SIZE(otgd->timers); i++)
>> +			hrtimer_cancel(&otgd->timers[i].timer);
>> +	}
>>  
>>  	flush_workqueue(otgd->wq);
>>  	fsm->otg->state = OTG_STATE_UNDEFINED;
>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>> index 22d8baa..ae9c30a 100644
>> --- a/include/linux/usb/otg-fsm.h
>> +++ b/include/linux/usb/otg-fsm.h
>> @@ -48,6 +48,11 @@ enum otg_fsm_timer {
>>  /**
>>   * struct otg_fsm - OTG state machine according to the OTG spec
>>   *
>> + * DRD mode hardware Inputs
>> + *
>> + * @id:		TRUE for B-device, FALSE for A-device.
>> + * @vbus:	VBUS voltage in regulation.
>> + *
>>   * OTG hardware Inputs
>>   *
>>   *	Common inputs for A and B device
>> @@ -122,7 +127,8 @@ enum otg_fsm_timer {
>>   */
>>  struct otg_fsm {
>>  	/* Input */
>> -	int id;
>> +	int id;			/* DRD + OTG */
>> +	int vbus;		/* DRD only */
> 
> Existing b_sess_vld can be also used for drd only case, no need create
> a new flag.

b_sess_vld is a bit confusing to people not familiar with OTG.
My suggestion is to use dedicated 'vbus' flag for DRD case
for simplicity.

> 
>>  	int adp_change;
>>  	int power_up;
>>  	int a_srp_det;

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
