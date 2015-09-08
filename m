From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 04/13] otg-fsm: move usb_bus_start_enum into
 otg-fsm->ops
Date: Tue, 8 Sep 2015 11:24:04 +0300
Message-ID: <55EE9B24.1090305@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-5-git-send-email-rogerq@ti.com>
 <20150907012437.GH4914@shlinux2> <55ED5F81.5060601@ti.com>
 <20150908065424.GC7802@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150908065424.GC7802@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/09/15 09:54, Peter Chen wrote:
> On Mon, Sep 07, 2015 at 12:57:21PM +0300, Roger Quadros wrote:
>> On 07/09/15 04:24, Peter Chen wrote:
>>> On Mon, Aug 24, 2015 at 04:21:15PM +0300, Roger Quadros wrote:
>>>> This is to prevent missing symbol build error if OTG is
>>>> enabled (built-in) and HCD core (CONFIG_USB) is module.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>> Acked-by: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>> ---
>>>>  drivers/usb/common/usb-otg-fsm.c | 6 ++++--
>>>>  drivers/usb/phy/phy-fsl-usb.c    | 2 ++
>>>>  include/linux/usb/otg-fsm.h      | 1 +
>>>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
>>>> index a46f29a..6e56c8c 100644
>>>> --- a/drivers/usb/common/usb-otg-fsm.c
>>>> +++ b/drivers/usb/common/usb-otg-fsm.c
>>>> @@ -165,8 +165,10 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>>>>  		otg_loc_conn(fsm, 0);
>>>>  		otg_loc_sof(fsm, 1);
>>>>  		otg_set_protocol(fsm, PROTO_HOST);
>>>> -		usb_bus_start_enum(fsm->otg->host,
>>>> -				fsm->otg->host->otg_port);usb_bus_start_enum
>>>> +		if (fsm->ops->start_enum) {
>>>> +			fsm->ops->start_enum(fsm->otg->host,
>>>> +					     fsm->otg->host->otg_port);
>>>> +		}
>>>>  		break;
>>>>  	case OTG_STATE_A_IDLE:
>>>>  		otg_drv_vbus(fsm, 0);
>>>> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
>>>> index ee3f2c2..19541ed 100644
>>>> --- a/drivers/usb/phy/phy-fsl-usb.c
>>>> +++ b/drivers/usb/phy/phy-fsl-usb.c
>>>> @@ -783,6 +783,8 @@ static struct otg_fsm_ops fsl_otg_ops = {
>>>>  
>>>>  	.start_host = fsl_otg_start_host,
>>>>  	.start_gadget = fsl_otg_start_gadget,
>>>> +
>>>> +	.start_enum = usb_bus_start_enum,
>>>>  };
>>>>  
>>>>  /* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
>>>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>>>> index 672551c..75e82cc 100644
>>>> --- a/include/linux/usb/otg-fsm.h
>>>> +++ b/include/linux/usb/otg-fsm.h
>>>> @@ -199,6 +199,7 @@ struct otg_fsm_ops {
>>>>  	void	(*del_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
>>>>  	int	(*start_host)(struct otg_fsm *fsm, int on);
>>>>  	int	(*start_gadget)(struct otg_fsm *fsm, int on);
>>>> +	int	(*start_enum)(struct usb_bus *bus, unsigned port_num);
>>>>  };
>>>>  
>>>>  
>>>
>>> Get one build warning:
>>>
>>> In file included from /u/home/b29397/work/projects/usb/drivers/usb/chipidea/udc.c:23:0:
>>> /u/home/b29397/work/projects/usb/include/linux/usb/otg-fsm.h:207:27: warning: 'struct usb_bus' declared inside parameter list
>>>   int (*start_enum)(struct usb_bus *bus, unsigned port_num);
>>>                              ^
>>> /u/home/b29397/work/projects/usb/include/linux/usb/otg-fsm.h:207:27: warning: its scope is only this definition or declaration, which is probably not what you want
>>>
>>> It probably dues to we should not have struct usb_bus* at udc driver
>>>
>> How about changing it to struct otg_fsm instead like the other APIs?
>> And do we leave usb_bus_start_enum() as it is?
>>
> 
> You have defined struct otg_hcd_ops to let otg visit hcd stuff, how
> about move this to otg_hcd_ops?

Yes, this is a better idea. Thanks.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
