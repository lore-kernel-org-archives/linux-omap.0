From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 04/11] otg-fsm: move usb_bus_start_enum into otg-fsm->ops
Date: Mon, 13 Jul 2015 13:13:54 +0300
Message-ID: <55A38F62.8010509@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-5-git-send-email-rogerq@ti.com> <20150713015759.GC27710@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713015759.GC27710@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Peter,

On 13/07/15 04:58, Peter Chen wrote:
> On Wed, Jul 08, 2015 at 01:19:30PM +0300, Roger Quadros wrote:
>> This is to prevent missing symbol build error if OTG is
>> enabled (built-in) and HCD core (CONFIG_USB) is module.
>>
> 
> We may let the OTG-DRD/OTG-FSM depends on CONFIG_USB to fix it.

CONFIG_OTG already depends on CONFIG_USB as it is a sub-option of
CONFIG_USB. It doesn't depend on CONFIG_USB_GADGET and that can
be fixed.

But dependency is not the problem here. Symbols not available to
OTG driver when USB/GADGET is 'm' is the problem.

e.g.
CONFIG_USB_OTG is always built-in.
we need to work if CONFIG_USB is 'm'/'y'
_and_ if CONFIG_USB_GADGET is 'm'/'y'

cheers,
-roger

> 
> Peter
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/common/usb-otg-fsm.c | 6 ++++--
>>  drivers/usb/phy/phy-fsl-usb.c    | 2 ++
>>  include/linux/usb/otg-fsm.h      | 1 +
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
>> index 1873eb3..156fd25 100644
>> --- a/drivers/usb/common/usb-otg-fsm.c
>> +++ b/drivers/usb/common/usb-otg-fsm.c
>> @@ -166,8 +166,10 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>>  		otg_loc_conn(fsm, 0);
>>  		otg_loc_sof(fsm, 1);
>>  		otg_set_protocol(fsm, PROTO_HOST);
>> -		usb_bus_start_enum(fsm->otg->host,
>> -				fsm->otg->host->otg_port);
>> +		if (fsm->ops->start_enum) {
>> +			fsm->ops->start_enum(fsm->otg->host,
>> +					     fsm->otg->host->otg_port);
>> +		}
>>  		break;
>>  	case OTG_STATE_A_IDLE:
>>  		otg_drv_vbus(fsm, 0);
>> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
>> index ee3f2c2..19541ed 100644
>> --- a/drivers/usb/phy/phy-fsl-usb.c
>> +++ b/drivers/usb/phy/phy-fsl-usb.c
>> @@ -783,6 +783,8 @@ static struct otg_fsm_ops fsl_otg_ops = {
>>  
>>  	.start_host = fsl_otg_start_host,
>>  	.start_gadget = fsl_otg_start_gadget,
>> +
>> +	.start_enum = usb_bus_start_enum,
>>  };
>>  
>>  /* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>> index c631dde..22d8baa 100644
>> --- a/include/linux/usb/otg-fsm.h
>> +++ b/include/linux/usb/otg-fsm.h
>> @@ -198,6 +198,7 @@ struct otg_fsm_ops {
>>  	void	(*del_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
>>  	int	(*start_host)(struct otg_fsm *fsm, int on);
>>  	int	(*start_gadget)(struct otg_fsm *fsm, int on);
>> +	int	(*start_enum)(struct usb_bus *bus, unsigned port_num);
>>  };
>>  
>>  
>> -- 
>> 2.1.4
>>
> 
