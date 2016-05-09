From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 11/14] usb: otg: use dev_dbg() instead of VDBG()
Date: Mon, 9 May 2016 12:48:28 +0300
Message-ID: <57305CEC.5010604@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-12-git-send-email-rogerq@ti.com>
 <20160506090425.GD32359@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160506090425.GD32359-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/05/16 12:04, Peter Chen wrote:
> On Mon, May 02, 2016 at 03:18:54PM +0300, Roger Quadros wrote:
>> Now that we have a device reference in struct usb_otg
>> let's use dev_dbg() for debug messages.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/common/usb-otg-fsm.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
>> index 2986b66..e6e58c2 100644
>> --- a/drivers/usb/common/usb-otg-fsm.c
>> +++ b/drivers/usb/common/usb-otg-fsm.c
>> @@ -30,13 +30,6 @@
>>  #include <linux/usb/otg.h>
>>  #include <linux/usb/otg-fsm.h>
>>  
>> -#ifdef VERBOSE
>> -#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
>> -				 __func__, ## args)
>> -#else
>> -#define VDBG(stuff...)	do {} while (0)
>> -#endif
>> -
>>  /* Change USB protocol when there is a protocol change */
>>  static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>>  {
>> @@ -44,8 +37,9 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>>  	int ret = 0;
>>  
>>  	if (fsm->protocol != protocol) {
>> -		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
>> -			fsm->protocol, protocol);
>> +		dev_vdbg(otg->dev,
>> +			 "Changing role fsm->protocol= %d; new protocol= %d\n",
>> +			 fsm->protocol, protocol);
>>  		/* stop old protocol */
>>  		if (fsm->protocol == PROTO_HOST)
>>  			ret = otg_start_host(otg, 0);
>> @@ -226,7 +220,7 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>>  
>>  	if (otg->state == new_state)
>>  		return 0;
>> -	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
>> +	dev_vdbg(otg->dev, "Set state: %s\n", usb_otg_state_string(new_state));
>>  	otg_leave_state(fsm, otg->state);
>>  	switch (new_state) {
>>  	case OTG_STATE_B_IDLE:
>> @@ -358,7 +352,7 @@ int otg_statemachine(struct usb_otg *otg)
>>  
>>  	switch (state) {
>>  	case OTG_STATE_UNDEFINED:
>> -		VDBG("fsm->id = %d\n", fsm->id);
>> +		dev_vdbg(otg->dev, "fsm->id = %d\n", fsm->id);
>>  		if (fsm->id)
>>  			otg_set_state(fsm, OTG_STATE_B_IDLE);
>>  		else
>> @@ -466,7 +460,8 @@ int otg_statemachine(struct usb_otg *otg)
>>  	}
>>  	mutex_unlock(&fsm->lock);
>>  
>> -	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
>> +	dev_vdbg(otg->dev, "quit statemachine, changed = %d\n",
>> +		 fsm->state_changed);
>>  	return fsm->state_changed;
>>  }
>>  EXPORT_SYMBOL_GPL(otg_statemachine);
>> -- 
> 
> Could you squash patch 2 with this one?
> 

We can't because at patch 2, otg->dev is not defined and we need patch 2
before patch 8 to prevent the build warning. This patch can come only
after patch 8 where we add otg->dev.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
