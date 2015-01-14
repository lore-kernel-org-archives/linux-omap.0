From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: dwc3 gadget fails on dra7-evm
Date: Wed, 14 Jan 2015 17:44:08 +0200
Message-ID: <54B68EC8.9000003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

In 3.19-rc4 on dra7-evm or dra72-evm

modprobe g_zero
[   34.680683] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
[   34.687074] zero gadget: zero ready
[   34.694133] dwc3 48890000.usb: failed to enable ep0out
[   34.701600] zero 48890000.usb: failed to start zero: -110
ERROR: could not insert 'g_zero': Connection timed out

my u-boot version is v2015.01

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
