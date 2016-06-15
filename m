From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Wed, 15 Jun 2016 10:14:39 +0300
Message-ID: <5761005F.4060303@ti.com>
References: <Pine.LNX.4.44L0.1606141018530.1574-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1606141018530.1574-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 14/06/16 17:21, Alan Stern wrote:
> On Tue, 14 Jun 2016, Roger Quadros wrote:
> 
>> +Alan
>>
>> On 10/06/16 16:07, Roger Quadros wrote:
>>> The OTG core will use struct otg_hcd_ops to interface
>>> with the HCD (Host Controller Driver).
>>>
>>> The main purpose of this interface is to avoid directly
>>> calling HCD APIs from the OTG core as they
>>> wouldn't be defined in the built-in symbol table if
>>> CONFIG_USB is m.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>> ---
>>>  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>>> index 66fc137..7729c1f 100644
>>> --- a/include/linux/usb/hcd.h
>>> +++ b/include/linux/usb/hcd.h
>>> @@ -400,6 +400,30 @@ struct hc_driver {
>>>  
>>>  };
>>>  
>>> +/**
>>> + * struct otg_hcd_ops - Interface between OTG core and HCD
>>> + *
>>> + * Provided by the HCD core to allow the OTG core to interface with the HCD
> 
> Add:  * in case the OTG core is built-in and the HCD core is built as a module.

OK.

> 
> Otherwise, for patches 1, 3, and 12:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 

Thanks.

cheers,
-roger
