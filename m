From: Sneeker Yeh <sneeker.yeh@gmail.com>
Subject: Re: [PATCH v3 1/5] xhci: add a quirk for device disconnection errata
 for Synopsis Designware USB3 core
Date: Sun, 15 Feb 2015 22:29:33 +0800
Message-ID: <CAJ1gpc3fSpVyYx52xk+r+aPJt4YBcP+9wLGo9bUnX-EE1MP-VQ@mail.gmail.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<1422173608-24355-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	<54DCAF88.4010607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54DCAF88.4010607@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Huang Rui <ray.huang@amd.com>, Kishon Vijay Abraham I <kishon@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andy Green <andy.green@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
List-Id: linux-omap@vger.kernel.org

hi Mathias:

thanks for reviewing these patch,
and sorry for replying lately~

2015-02-12 21:50 GMT+08:00 Mathias Nyman <mathias.nyman@intel.com>:
> On 25.01.2015 10:13, Sneeker Yeh wrote:
>> This issue is defined by a three-way race at disconnect, between
>> 1) Class driver interrupt endpoint resheduling attempts if the ISR gave an ep
>>    error event due to device detach (it would try 3 times)
>> 2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
>>    asynchronously
>> 3) The hardware IP was configured in silicon with
>>    - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1
>>    - Synopsys IP version is < 3.00a
>> The IP will auto-suspend itself on device detach with some phy-specific interval
>> after CSC is cleared by 2)
>>
>> If 2) and 3) complete before 1), the interrupts it expects will not be generated
>> by the autosuspended IP, leading to a deadlock. Even later disconnection
>> procedure would detect that corresponding urb is still in-progress and issue a
>> ep stop command, auto-suspended IP still won't respond to that command.
>>
>
> So did I understand correctly that the class driver submits a new urb which
> is enqueued by xhci_urb_enqueue() before the hub thread notices the device is disconnected.
> Then hub thread clears CSC bit, controller suspends and the new urb is never given back?

yes.

>
> Doesn't the CSC bit and PORT_CONNECT bit show the device is disconnected when we enter
> xhci_enqueue_urb(), even it the hub thread doesn't know this yet?
>
> Would it make sense to check those bits in xhci_enqueue_urb, and just return error
> in the xhci_urb_enqueue() if device is not connected? Then there wouldn't be a need for any quirk
> at all.

ya I tried this before, it would work if i stop enqueue when i found
device detached,
but sometime it won't work when device might be detached just right
after i done enqueue, just like Alan mentioned.

>
> If that doesn't work then this patch looks good in general. See comments below
>
>> this defect would result in this when device detached:
>> -------------------------------------------------------
>> [   99.603544] usb 4-1: USB disconnect, device number 2
>> [  104.615254] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
>> [  104.623362] xhci-hcd xhci-hcd.0.auto: Assuming host is dying, halting host.
>> [  104.653261] xhci-hcd xhci-hcd.0.auto: Host not halted after 16000 microseconds.
>> [  104.660584] xhci-hcd xhci-hcd.0.auto: Non-responsive xHCI host is not halting.
>> [  104.667817] xhci-hcd xhci-hcd.0.auto: Completing active URBs anyway.
>> [  104.674198] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
>> ------------------------------------------------------
>> As a result, when device detached, we desired to postpone "PORTCSC clear" behind
>> "disable slot". it's found that all executed ep command related to disconnetion,
>> are executed before "disable slot".
>>
>> Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
>> ---
>>  drivers/usb/host/xhci-hub.c |    4 ++++
>>  drivers/usb/host/xhci.c     |   29 +++++++++++++++++++++++++++++
>>  drivers/usb/host/xhci.h     |   24 ++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index a7865c4..3b8f7fc 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -368,6 +368,10 @@ static void xhci_clear_port_change_bit(struct xhci_hcd *xhci, u16 wValue,
>>               port_change_bit = "warm(BH) reset";
>>               break;
>>       case USB_PORT_FEAT_C_CONNECTION:
>> +             if ((xhci->quirks & XHCI_DISCONNECT_QUIRK) &&
>> +                 !(readl(addr) & PORT_CONNECT))
>> +                     return;
>> +
>
> New port status event are prevented until CSC is cleared, not sure if there's any harm in that?

hub thread would be aware of device detach before he try to clear PORTCSC, IIUC,
Despite I skip clearing PORTCSC here, whole device detach procedure
still behave normally.

>
>>               status = PORT_CSC;
>>               port_change_bit = "connect";
>>               break;
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index c50d8d2..aa8e02a 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -3584,6 +3584,33 @@ command_cleanup:
>>       return ret;
>>  }
>>
>> +static void xhci_try_to_clear_csc(struct usb_hcd *hcd, int dev_port_num)
>> +{
>> +     int max_ports;
>> +     struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> +     __le32 __iomem **port_array;
>> +     u32 status;
>> +
>> +     /* print debug info */
>> +     if (hcd->speed == HCD_USB3) {
>> +             max_ports = xhci->num_usb3_ports;
>> +             port_array = xhci->usb3_ports;
>> +     } else {
>> +             max_ports = xhci->num_usb2_ports;
>> +             port_array = xhci->usb2_ports;
>> +     }
>> +
>> +     if (dev_port_num > max_ports) {
>> +             xhci_err(xhci, "%s() port number invalid", __func__);
>> +             return;
>> +     }
>> +     status = readl(port_array[dev_port_num - 1]);
>> +
>> +     /* write 1 to clear */
>> +     if (!(status & PORT_CONNECT) && (status & PORT_CSC))
>> +             writel(status & PORT_CSC, port_array[0]);
>
> Shouldn't this be writel(...,port_array[dev_port_num - 1]) ?

yes, thanks for correcting this,
and I also would like to add xhci_port_state_to_neutral() you mentioned.
what would you think if I modify it like this?

+       /* write 1 to clear */
+       if (!(status & PORT_CONNECT) && (status & PORT_CSC)) {
+               status = xhci_port_state_to_neutral(status);
+               writel(status | PORT_CSC, port_array[dev_port_num - 1]);
+       }

Much appreciate,
Sneeker


>
> -Mathias
