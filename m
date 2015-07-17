From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 10/11] usb: otg: Add dual-role device (DRD) support
Date: Fri, 17 Jul 2015 13:41:31 +0300
Message-ID: <55A8DBDB.5080304@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-11-git-send-email-rogerq@ti.com> <20150717081427.GB4515@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717081427.GB4515@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Jun <b47624@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17/07/15 11:14, Li Jun wrote:
> Hi,
> 
> On Wed, Jul 08, 2015 at 01:19:36PM +0300, Roger Quadros wrote:
>> DRD mode is a reduced functionality OTG mode. In this mode
>> we don't support SRP, HNP and dynamic role-swap.
>>
>> In DRD operation, the controller mode (Host or Peripheral)
>> is decided based on the ID pin status. Once a cable plug (Type-A
>> or Type-B) is attached the controller selects the state
>> and doesn't change till the cable in unplugged and a different
>> cable type is inserted.
>>
>> As we don't need most of the complex OTG states and OTG timers
>> we implement a lean DRD state machine in usb-otg.c.
>> The DRD state machine is only interested in 2 hardware inputs
>> 'id' and 'vbus; that are still passed via the origintal struct otg_fsm.
>>
>> Most of the usb-otg.c functionality remains the same except
>> adding a new parameter to usb_otg_register() to indicate that
>> the OTG controller needs to operate in DRD mode.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/common/usb-otg.c | 179 ++++++++++++++++++++++++++++++++++++++++---
>>  include/linux/usb/otg-fsm.h  |   8 +-
>>  include/linux/usb/otg.h      |   5 +-
>>  3 files changed, 180 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>> index 1f19001..9b89f4b 100644
>> --- a/drivers/usb/common/usb-otg.c
>> +++ b/drivers/usb/common/usb-otg.c
>> @@ -44,6 +44,7 @@ struct otg_hcd {
>>  struct otg_data {
>>  	struct device *dev;	/* HCD & GCD's parent device */
>>  
>> +	bool drd_only;		/* Dual-role only, no OTG features */
> 
> After we introduce otg caps, we can use hnp_support to judge it it's
> drd or OTG.

Yes. I will rebase this series on top of your otg_caps patches
and incorporate it.

> 
>>  	struct otg_fsm fsm;
>>  	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
>>  	 * HCD is bus_to_hcd(fsm->otg->host)
>> @@ -272,20 +273,172 @@ static int usb_otg_start_gadget(struct otg_fsm *fsm, int on)
>>  	return 0;
>>  }
>>  
>> +/* Change USB protocol when there is a protocol change */
>> +static int drd_set_protocol(struct otg_fsm *fsm, int protocol)
>> +{
>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>> +	int ret = 0;
>> +
>> +	if (fsm->protocol != protocol) {
>> +		dev_dbg(otgd->dev, "otg: changing role fsm->protocol= %d; new protocol= %d\n",
>> +			fsm->protocol, protocol);
>> +		/* stop old protocol */
>> +		if (fsm->protocol == PROTO_HOST)
>> +			ret = otg_start_host(fsm, 0);
>> +		else if (fsm->protocol == PROTO_GADGET)
>> +			ret = otg_start_gadget(fsm, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* start new protocol */
>> +		if (protocol == PROTO_HOST)
>> +			ret = otg_start_host(fsm, 1);
>> +		else if (protocol == PROTO_GADGET)
>> +			ret = otg_start_gadget(fsm, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		fsm->protocol = protocol;
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Called when entering a DRD state */
>> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>> +{
>> +	struct otg_data *otgd = container_of(fsm, struct otg_data, fsm);
>> +
>> +	if (fsm->otg->state == new_state)
>> +		return;
>> +
>> +	fsm->state_changed = 1;
>> +	dev_dbg(otgd->dev, "otg: set state: %s\n",
>> +		usb_otg_state_string(new_state));
>> +	switch (new_state) {
>> +	case OTG_STATE_B_IDLE:
> 
> otg_drv_vbus(fsm, 0);
> 
>> +		drd_set_protocol(fsm, PROTO_UNDEF);
>> +		break;
>> +	case OTG_STATE_B_PERIPHERAL:
> 
> otg_drv_vbus(fsm, 0);
> 
>> +		drd_set_protocol(fsm, PROTO_GADGET);
>> +		break;
>> +	case OTG_STATE_A_HOST:
> 
> otg_drv_vbus(fsm, 1);

OK.

> 
>> +		drd_set_protocol(fsm, PROTO_HOST);
>> +		break;
>> +	case OTG_STATE_UNDEFINED:
>> +	case OTG_STATE_B_SRP_INIT:
>> +	case OTG_STATE_B_WAIT_ACON:
>> +	case OTG_STATE_B_HOST:
>> +	case OTG_STATE_A_IDLE:
>> +	case OTG_STATE_A_WAIT_VRISE:
>> +	case OTG_STATE_A_WAIT_BCON:
>> +	case OTG_STATE_A_SUSPEND:
>> +	case OTG_STATE_A_PERIPHERAL:
>> +	case OTG_STATE_A_WAIT_VFALL:
>> +	case OTG_STATE_A_VBUS_ERR:
>> +	default:
>> +		dev_warn(otgd->dev, "%s: otg: invalid state: %s\n",
>> +			 __func__, usb_otg_state_string(new_state));
>> +		break;
>> +	}
>> +
>> +	fsm->otg->state = new_state;
>> +}
>> +

cheers,
-roger
