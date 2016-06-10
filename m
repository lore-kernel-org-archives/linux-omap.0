From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v9 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Fri, 10 Jun 2016 10:01:57 +0300
Message-ID: <575A65E5.6030908@ti.com>
References: <Pine.LNX.4.44L0.1606091008210.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1606091008210.1697-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/06/16 17:11, Alan Stern wrote:
> On Thu, 9 Jun 2016, Sergei Shtylyov wrote:
> 
>> Hello.
>>
>> On 6/9/2016 10:31 AM, Roger Quadros wrote:
>>
>>>>>>> The OTG core will use struct otg_hcd_ops to interface
>>>>>>> with the HCD controller.
>>>>>>
>>>>>>    Host controller driver (HCD) controller? Maybe just HC? :-)
>>>>>
>>>>> OK.
>>>>
>>>>    OTOH, my googling has shown that HCD may stand for both HC driver and HC device... The host controller device sounds a bit tautological however...
>>>
>>> Yeah I always meant it to be Host Controller Device :).
>>
>>     The question here is more what was meant by the previous Linux USB 
>> authors. :-)
> 
> I have always used "HCD" to mean Host Controller Driver, and I believe 
> that's what other people have done too.
> 
> If I want to refer to a Host Controller Device, I would write either
> "HC" or "host controller".
> 
> Admittedly, this means that struct usb_hcd has a slightly illogical 
> name.
> 

OK, I'll re-spin this series so that HCD means HC driver.

cheers,
-roger
