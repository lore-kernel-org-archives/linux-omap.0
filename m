From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 06/13] usb: hcd: Add hcd add/remove functions
 for OTG use
Date: Tue, 21 Apr 2015 10:02:30 +0300
Message-ID: <5535F606.2070000@ti.com>
References: <Pine.LNX.4.44L0.1504200948280.1321-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35068 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbDUHCv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2015 03:02:51 -0400
In-Reply-To: <Pine.LNX.4.44L0.1504200948280.1321-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <peter.chen@freescale.com>, gregkh@linuxfoundation.org, balbi@ti.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 20/04/15 16:56, Alan Stern wrote:
> On Mon, 20 Apr 2015, Roger Quadros wrote:
> 
>>> I don't understand this.  Why do you want to defer the add/remove if 
>>> the device is OTG?  Don't host controller drivers expect these things 
>>> to execute synchronously?
>>
>> Sorry for the wrong information. We actually defer only the add as the
>> OTG state machine might not yet be in Host ready mode.
>> The remove is always synchronous and we ensure that the HCD is removed
>> when usb_otg_unregister_hcd() returns.
> 
> That's okay then, but it does leave one potential hole.  What happens 
> if usb_add_hcd() is deferred for so long that usb_remove_hcd() gets 
> called before the add can complete?

We keep track of the HCD state in the OTG state machine and if it was not
yet added then _usb_remove_hcd() is not called during usb_otg_unregister_hcd()
in the usb_remove_hcd() call.

cheers,
-roger

