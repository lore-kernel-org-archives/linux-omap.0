From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Thu, 10 Sep 2015 17:14:08 +0300
Message-ID: <55F19030.9090800@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-8-git-send-email-rogerq@ti.com>
 <20150907074002.GA30578@shlinux2> <55ED6C9F.2000502@ti.com>
 <20150909062006.GB812@shlinux2> <55F0036A.60403@ti.com>
 <20150910092854.GA7703@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150910092854.GA7703@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Jun <b47624-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/09/15 12:28, Li Jun wrote:
> On Wed, Sep 09, 2015 at 01:01:14PM +0300, Roger Quadros wrote:
> ... ...
> 
>>>>>> +	return -EINVAL;
>>>>>
>>>>> Return non-zero, then if err, do we need call usb_otg_add_hcd() after
>>>>> usb_otg_register_hcd() fails?
>>>>
>>>> You should not call usb_otg_register_hcd() but usb_add_hcd().
>>>> If that fails then you fail as ususal.
>>>
>>> My point is if we use usb_add_hcd(), but failed in usb_otg_register_hcd(),
>>> then usb_otg_add_hcd() will be called in *all* error case, is this your
>>> expectation?
>>> 	if (usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf))
>>> 		return usb_otg_add_hcd(hcd, irqnum, irqflags);
>>>
>>
>> Yes, my intention was that if otg fails then it is a non otg HCD so register normally.
>> Let me correct my previous statement. If you are absolutely sure
>> that the HCD is for otg/dual-role usage then you should call usb_otg_register_hcd().
>>
> 
> I think this is not just about a statement, in your usb_otg_register_hcd()
> implementation, there are several places will return error, I think only
> the first two are for a non-otg HCD case, the following error cases seems
> mean this is for otg usage, but it fails in middle of registration, if that
> is the case, is it reasonable to call usb_otg_add_hcd()?

OK. We need to check the return value then and differentiate if it is non-otg
or otg with failure.
If it is non-otg then only we must call usb_otg_add_hcd().

I will fix usb_add_hcd().

> 
>>>>>> + * @fsm_running: state machine running/stopped indicator
>>>>>> + */
>>>>>>  struct usb_otg {
>>>>>>  	u8			default_a;
>>>>>>  
>>>>>>  	struct phy		*phy;
>>>>>>  	/* old usb_phy interface */
>>>>>>  	struct usb_phy		*usb_phy;
>>>>>> +
>>>>>
>>>>> add a blank line?
>>>>>
>>>
>>> You missed this.
>>
>> Sorry. Did you suggest to remove that blank line
>> or add a new one before usb_phy?
>>
> 
> Remove it.

OK.

> 
>>>
>>>>>>  	struct usb_bus		*host;
>>>>>>  	struct usb_gadget	*gadget;
>>>>>>  
>>>>>>  	enum usb_otg_state	state;
>>>>>>  
>>>>>> +	struct device *dev;
>>>>>> +	struct usb_otg_caps *caps;
>>>>>> +	struct otg_fsm fsm;
>>>>>> +	struct otg_fsm_ops fsm_ops;
>>>>>> +
>>>>>> +	/* internal use only */
>>>>>> +	struct otg_hcd primary_hcd;
>>>>>> +	struct otg_hcd shared_hcd;
>>>>>> +	struct otg_gadget_ops *gadget_ops;
>>>>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>>>>>> +	struct list_head list;
>>>>>> +	struct work_struct work;
>>>>>> -- 
>>>>>> 2.1.4
>>>
--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
