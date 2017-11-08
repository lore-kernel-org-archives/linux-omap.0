From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: USB regression in next-20171108 with hub spamming
Date: Wed, 8 Nov 2017 15:05:11 -0800
Message-ID: <20171108230511.GY28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe & Greg,

Looks like in next-20171108 USB hub is spamming console about once a
second after commit 7dfd74fd128 ("Merge remote-tracking branch
'usb/usb-next'").

Any ideas? See the log below.

Regards,

Tony

8< ------------------------------
ohci-platform 4a064800.ohci: Generic Platform OHCI controller
ohci-platform 4a064800.ohci: new USB bus registered, assigned bus number 1
ohci-platform 4a064800.ohci: irq 146, io mem 0x4a064800
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Generic Platform OHCI controller
usb usb1: Manufacturer: Linux 4.14.0-rc8-next-20171108+ ohci_hcd
usb usb1: SerialNumber: 4a064800.ohci
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: config failed, can't get hub status (err 2)
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
hub 1-0:1.0: activate --> -22
...
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
