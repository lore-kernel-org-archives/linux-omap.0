From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Fri, 13 Feb 2015 10:54:08 +0200
Message-ID: <54DDBBB0.7070602@linux.intel.com>
References: <Pine.LNX.4.44L0.1502121013390.1209-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1502121013390.1209-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Mathias Nyman <mathias.nyman@intel.com>, Sneeker Yeh <sneeker.yeh@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

On 12.02.2015 17:18, Alan Stern wrote:
> On Thu, 12 Feb 2015, Mathias Nyman wrote:
> 
>> On 25.01.2015 10:13, Sneeker Yeh wrote:
>>> This issue is defined by a three-way race at disconnect, between
>>> 1) Class driver interrupt endpoint resheduling attempts if the ISR gave an ep
>>>    error event due to device detach (it would try 3 times)
>>> 2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
>>>    asynchronously
>>> 3) The hardware IP was configured in silicon with
>>>    - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1
>>>    - Synopsys IP version is < 3.00a
>>> The IP will auto-suspend itself on device detach with some phy-specific interval
>>> after CSC is cleared by 2)
>>>
>>> If 2) and 3) complete before 1), the interrupts it expects will not be generated
>>> by the autosuspended IP, leading to a deadlock. Even later disconnection
>>> procedure would detect that corresponding urb is still in-progress and issue a
>>> ep stop command, auto-suspended IP still won't respond to that command.
> 
> If the Synopsys IP provides a way to do it, it would be better to turn
> off the autosuspend feature entirely.  Doesn't autosuspend violate the
> xHCI specification?
> 
>> So did I understand correctly that the class driver submits a new urb which
>> is enqueued by xhci_urb_enqueue() before the hub thread notices the device is disconnected.
>> Then hub thread clears CSC bit, controller suspends and the new urb is never given back?
>>
>> Doesn't the CSC bit and PORT_CONNECT bit show the device is disconnected when we enter
>> xhci_enqueue_urb(), even it the hub thread doesn't know this yet?
> 
> What if the device disconnects _after_ the new URB is enqueued?

True, those URBs would be left hanging.

So if possible, tweaking the Synopsis autosuspend feature would be nicer.

If its not possible then I guess a quirk patch like this will do.

-Mathias


 
