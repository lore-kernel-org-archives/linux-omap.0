From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: Direct IP and USB modem
Date: Mon, 15 Oct 2012 21:18:21 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE070B5F3F5@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm24-vm6.bullet.mail.ukl.yahoo.com ([217.146.176.222]:29389
	"EHLO nm24-vm6.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab2JOVXp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 17:23:45 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'linux-omap@vger.kernel.org'" <linux-omap@vger.kernel.org>

Hello,
I have been transitioning from 2.6.37 kernel to 3.6-rc6 and have most t=
hings running that I had previously.

Next hurdle is the Sierra Wireless 8705 card.=A0 I have tried the kerne=
l drivers for this device and the latest from the Sierra Wireless site =
but both result in the same.=A0 When I try to setup the PDP context, wh=
ich is needed for the setup of the wwan0 interface I get the following =
error;

Going to send : AT!SCACT=3D1,1
[=A0=A0 77.037811] sierra_net 1-1.3:1.7: wwan0: Link type unsupported: =
0xff
[=A0=A0 77.044433] sierra_net 1-1.3:1.7: wwan0: Invalid LSI
AT!SCACT=3D1,1
ERROR

I have had a look in the sierra_net code and the return for Link type u=
nsupported and for some reason its not configured;
=A0=A0=A0 /* Validate the link type */
=A0=A0 if ((lsi->link_type !=3D SIERRA_NET_AS_LINK_TYPE_IPv4) &&
=A0=A0=A0=A0=A0=A0=A0 (lsi->link_type !=3D SIERRA_NET_AS_LINK_TYPE_IPv6=
)) {

And then the Invalid LSI is in response again to the device structure n=
ot being configured.

I was hoping someone out there has knowledge about additional component=
s that might be needed to get this to work, or what might have changed =
from 2.6.37 that needs implementing in the latest driver ?

I have also searched for other issues and it may be related, when the d=
evice is detected and installed there is a complaint about invalid inte=
rface number;
[=A0=A0 28.232543] usb 1-1.3: new high-speed USB device number 4 using =
ehci-omap
[=A0=A0 28.358734] usb 1-1.3: config 1 has an invalid interface number:=
 7 but max is 5
[=A0=A0 28.366424] usb 1-1.3: config 1 has no interface number 5
[=A0=A0 28.374114] usb 1-1.3: New USB device found, idVendor=3D1199, id=
Product=3D68a3
[=A0=A0 28.381317] usb 1-1.3: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D4
[=A0=A0 28.388977] usb 1-1.3: Product: MC8705
[=A0=A0 28.392883] usb 1-1.3: Manufacturer: Sierra Wireless, Incorporat=
ed
[=A0=A0 28.399353] usb 1-1.3: SerialNumber: 353567040114127
[=A0=A0 28.466918] usbcore: registered new interface driver usbserial
[=A0=A0 28.473114] usbcore: registered new interface driver usbserial_g=
eneric
[=A0=A0 28.518005] USB Serial support registered for generic
[=A0=A0 28.523559] usbserial: USB Serial Driver core
[=A0=A0 28.531127] usbcore: registered new interface driver sierra
[=A0=A0 28.547454] sierra_net 1-1.3:1.7: wwan0: register 'sierra_net' a=
t usb-ehci-omap.0-1.3, Sierra Wireless USB-to-WWAN Modem, a6:3d:31:a8:0=
1:07
[=A0=A0 28.561248] USB Serial support registered for Sierra USB modem
[=A0=A0 28.573669] sierra 1-1.3:1.0: Sierra USB modem converter detecte=
d
[=A0=A0 28.580841] usbcore: registered new interface driver sierra_net
[=A0=A0 28.596099] usb 1-1.3: Sierra USB modem converter now attached t=
o ttyUSB0
[=A0=A0 28.626525] sierra 1-1.3:1.1: Sierra USB modem converter detecte=
d
[=A0=A0 28.693054] usb 1-1.3: Sierra USB modem converter now attached t=
o ttyUSB1
[=A0=A0 28.740051] sierra 1-1.3:1.2: Sierra USB modem converter detecte=
d
[=A0=A0 28.776702] usb 1-1.3: Sierra USB modem converter now attached t=
o ttyUSB2
[=A0=A0 28.818206] sierra 1-1.3:1.3: Sierra USB modem converter detecte=
d
[=A0=A0 28.849243] usb 1-1.3: Sierra USB modem converter now attached t=
o ttyUSB3
[=A0=A0 28.888488] sierra 1-1.3:1.4: Sierra USB modem converter detecte=
d
[=A0=A0 28.913116] usb 1-1.3: Sierra USB modem converter now attached t=
o ttyUSB4

Hope someone can help.

Regards
Marc
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
