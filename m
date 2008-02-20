From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: OMAP34xx EHCI bulk OUT CRC16 complementing
Date: Wed, 20 Feb 2008 11:17:01 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC080044F7C2C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

USB EHCI/OHCI experts

On omap-git v2.6.25-rc2, TI OMAP34xx EHCI controller, we are seeing a strange behavior on a bulk OUT 512 byte transfer.

We can see through the CATC that the 512 byte goes out successfully but there are many Turnaround/Timeout Errors and retries before the packet goes out successfully. 
The retries could range from 0 to 10 or more.

The error packets have 'CRC16 complemented' as per Section 8.6.4 page 234-235 that says for probably a data under-run condition:
"An error for high-speed must be forced by taking the currently calculated CRC and complementing it before transmitting it."

We have confirmed that our Memory (SDRAM) access have a much higher bandwidth available "not" to cause data under-run condition.

Where in EHCI stack should I debug for this issue? 

I am checking: qh_append_tds()
Not sure how this "Dummy" qtd is implemented. Anything to do with this? 

Is there a way to slow-down the OUT transfers on EHCI if that helps in debugging? 

Regards
