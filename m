From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC] wilink8-bluetooth: reading uart parametrs and enable pin
 info from device tree
Date: Tue, 27 Sep 2016 13:16:18 +0200
Message-ID: <08201AAB-F999-466D-A003-93FFFA5EE517@holtmann.org>
References: <8665E2433BC68541A24DFFCA87B70F5B361A3A3E@DFRE01.ent.ti.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B361A3A3E-1tpBd5JUCm6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Eyal,

> The wl18xx family of chips include a Bluetooth subsystem which uses a UART 
> for HCI communication and a gpio as an enable pin.
> 
> See the following architecture diagram:
> http://www.ti.com/general/docs/datasheetdiagram.tsp?genericPartNumber=WL1837MOD&diagramId=SWRS170H
> 
> In case we want to build an image that when it boots up, Bluetooth is enbled 
> out of the box we can pass this info to a user space app/script that would pick 
> the selected gpio, enable it and launch the bleutooth stack (using hciattach).
> 
> The question is what would be the right practice for passing these parameters.
> As there is no kernel driver looking for this info and it is needed mainly 
> By user space, should we use something like the chosen node?
> If yes, would it be right to add a new chosen node entry, or just add additional
> Parameters to bootargs?
> Any other suggestion?

actually that is a job for DT to describe the GPIO and then let the driver handle it. See how we do it with ACPI provided information for Intel and Broadcom UART drivers.

The goal is that btattach just attaches the line discipline. And anything else is done via the driver on hdev->setup or when bringing up the controller. That is how we drive all the other UART chips now.

As a side note, I would also prefer that the TI-ST part gets cleaned up. We have devres and other devices stacked on top of the Bluetooth HCI should be exposed as slaves. See the Intel driver for an example.

At some point we might get the serial / UART bus that has been recently discussed. That would be even better and btattach would not be needed at all. The driver would attach itself. However we still need to drive the GPIO from the driver and not some external user space program. That is not going to fly.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
