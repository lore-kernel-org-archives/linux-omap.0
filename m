From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Wed, 8 Jun 2016 15:04:57 +0300
Message-ID: <575809E9.7010409@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-4-git-send-email-rogerq@ti.com>
 <5bc321c0-fb36-7a4a-d054-ee73b12822d4@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5bc321c0-fb36-7a4a-d054-ee73b12822d4@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/06/16 14:39, Sergei Shtylyov wrote:
> Hello.
> 
> On 6/8/2016 12:03 PM, Roger Quadros wrote:
> 
>> The OTG core will use struct otg_hcd_ops to interface
>> with the HCD controller.
> 
>    Host controller driver (HCD) controller? Maybe just HC? :-)

OK.

> 
>> The main purpose of this interface is to avoid directly
>> calling HCD APIs from the OTG core as they
>> wouldn't be defined in the built-in symbol table if
>> CONFIG_USB is m.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>> index 66fc137..7914bed 100644
>> --- a/include/linux/usb/hcd.h
>> +++ b/include/linux/usb/hcd.h
>> @@ -400,6 +400,30 @@ struct hc_driver {
>>
>>  };
>>
>> +/**
>> + * struct otg_hcd_ops - Interface between OTG core and HCD
>> + *
>> + * Provided by the HCD core to allow the OTG core to interface with the HCD
>> + *
>> + * @add: function to add the HCD
>> + * @remove: function to remove the HCD
>> + * @usb_bus_start_enum: function to immediately start bus enumeration
>> + * @usb_control_msg: function to build and send of a control urb
> 
>    That "of" is not needed. And it's URB.

Right.
> 
> [...]
> 
