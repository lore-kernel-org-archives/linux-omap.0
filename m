From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 03/10] usb: dwc3: omap: Pass VBUS and ID events
 transparently
Date: Mon, 11 Apr 2016 16:03:45 +0300
Message-ID: <570BA0B1.1060404@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
 <1460374506-9779-4-git-send-email-rogerq@ti.com> <87egacnxtr.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87egacnxtr.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/04/16 15:18, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> Don't make any decisions regarding VBUS session based on ID
>> status. That is best left to the OTG core.
> 
> what about builds who don't want OTG and/or dual-role ?
> 
>> Pass ID and VBUS events independent of each other so that OTG
>> core knows exactly what to do.
>>
>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/dwc3-omap.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 51ca098..c9b918d 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -233,19 +233,14 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
>>  		}
>>  
>>  		val = dwc3_omap_read_utmi_ctrl(omap);
>> -		val &= ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
>> -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
>> -				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
>> -		val |= USBOTGSS_UTMI_OTG_CTRL_SESSVALID
>> -				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
>> +		val &= ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;
> 
> this creates the possibility of having a USB peripheral with VBUS_VALID,
> right 

Sorry, I didn't get what you meant.

> 
>>  		dwc3_omap_write_utmi_ctrl(omap, val);
>>  		break;
>>  
>>  	case OMAP_DWC3_VBUS_VALID:
>>  		val = dwc3_omap_read_utmi_ctrl(omap);
>>  		val &= ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
>> -		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG
>> -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
>> +		val |= USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
>>  				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID
>>  				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
> 
> I remember discussing this with TI's IP owner back in OMAP5 days. This
> code was a result of talking to that guy and was, back then, tested by
> Silicon Validation team. I would strongly advise that before changing
> these bits you check with whoever's currently handling this IP inside TI
> to make sure your changes are still within the expectations of the
> wrapper block.
> 
OK, I wasn't aware about this. I will check with the Silicon team.

cheers,
-roger
