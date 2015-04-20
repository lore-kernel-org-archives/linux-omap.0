From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 06/13] usb: hcd: Add hcd add/remove functions
 for OTG use
Date: Mon, 20 Apr 2015 10:00:36 +0300
Message-ID: <5534A414.4070401@ti.com>
References: <Pine.LNX.4.44L0.1504170958440.1319-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1504170958440.1319-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <peter.chen@freescale.com>, gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17/04/15 17:03, Alan Stern wrote:
> On Fri, 17 Apr 2015, Roger Quadros wrote:
> 
>> On 17/04/15 05:18, Peter Chen wrote:
>>> On Tue, Apr 14, 2015 at 01:41:53PM +0300, Roger Quadros wrote:
>>>> The existing usb_add/remove_hcd() functionality
>>>> remains unchanged for non-OTG devices. For OTG
>>>> devices they only register the HCD with the OTG core.
>>>>
>>>> Introduce _usb_add/remove_hcd() for use by OTG core.
>>>> These functions actually add/remove the HCD.
>>>
>>> Would you please explain why additional _usb_add/remove_hcd are needed?
>>
>> It is to differentiate if the add/remove_hcd was called by the
>> HCD drivers or by the OTG core as we want to behave a bit differently
>> in both cases.
>> When called by HCD drivers, we want to defer the add/remove if it is an
>> OTG device. When called by OTG core, we don't want to defer the add/remove.
> 
> I don't understand this.  Why do you want to defer the add/remove if 
> the device is OTG?  Don't host controller drivers expect these things 
> to execute synchronously?

Sorry for the wrong information. We actually defer only the add as the
OTG state machine might not yet be in Host ready mode.
The remove is always synchronous and we ensure that the HCD is removed
when usb_otg_unregister_hcd() returns.

> 
> For example, what happens if you rmmod the HCD?  If the remove call
> gets deferred, then when it finally runs it will try to call back into
> HCD code that has already been unloaded from memory!
> 
>> HCD drivers use usb_add/remove_hcd()
>> OTG core uses _usb_add/remove_hcd()
> 
> How about a more explicit naming scheme?
> 
> 	HC drivers use usb_add/remove_hcd()
> 	OTG core uses usb_otg_add/remove_hcd()

Yes, this is better.

cheers,
-roger
