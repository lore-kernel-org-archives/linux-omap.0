From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: [RFC] wilink8-bluetooth: reading uart parametrs and enable pin info
 from device tree
Date: Tue, 27 Sep 2016 10:35:57 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B361A3A3E@DFRE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

All,

The wl18xx family of chips include a Bluetooth subsystem which uses a UART 
for HCI communication and a gpio as an enable pin.

See the following architecture diagram:
http://www.ti.com/general/docs/datasheetdiagram.tsp?genericPartNumber=WL1837MOD&diagramId=SWRS170H

In case we want to build an image that when it boots up, Bluetooth is enbled 
out of the box we can pass this info to a user space app/script that would pick 
the selected gpio, enable it and launch the bleutooth stack (using hciattach).

The question is what would be the right practice for passing these parameters.
As there is no kernel driver looking for this info and it is needed mainly 
By user space, should we use something like the chosen node?
If yes, would it be right to add a new chosen node entry, or just add additional
Parameters to bootargs?
Any other suggestion?

Best Regards,
Eyal Reizer
