From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Modify the usb power budget in OSK
Date: Sun, 26 Mar 2006 19:42:08 -0600
Message-ID: <3D54759CE5A8F64BB2078090E91D50A20EDBE7@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: chief@verat.net, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

 Did you measure the actual voltage with a DMM
(ideally oscilloscope)?

 The OSK5912 uses the TPS2045 for USB targets
power, whose max current is 250[mA].

 http://focus.ti.com/lit/ds/symlink/tps2045.pdf

 In my experience, the warming message was safely
ignored as far as the power is supplied externally.

 Regards,
 Ishigami

-----Original Message-----
From: Djordje Nijemcevic
Sent: Friday, March 24, 2006 10:28 PM
To: linux-omap-open-source@linux.omap.com
Subject: Re: Modify the usb power budget in OSK

Hello,

We have the same problem with our web camera... We're using an external
power supply for USB.

First, we modified the line in ohci-omap.c
ohci_to_hcd(ohci)->power_budget =3D 250;
to
ohci_to_hcd(ohci)->power_budget =3D 500;

After that modification, during the boot process, we still got the
message
"400mA over 100mA budget"
By searching the files containing string "mA budget", we have found
inside
hub.c

		/* 100mA per-port ceiling, or 8mA for OTG ports */
		if (i !=3D (udev->bus->otg_port - 1) || hdev->parent)
			ceiling =3D 50;
		else
			ceiling =3D 4;

In the rest of the source, the value 'ceiling' is considered as a half
the
maximum power that the USB port can give. After modifying the 'ceiling'
value from 50 (which corresponds to 100mA) to 250 (corresponds to 500mA)
we didn't have the boot message mentioned anymore, but the camera still
doesn't work, nor its LED :( But, you might give a try with this.

It looks strange to me that hub.c is even needed, as well as there is
100mA limit inside of it. We still doubt that our camera doesn't work
due
to some power budget-related issue. Is something else to be modified?

TIA
Djordje Nijemcevic

> Hi all,
>
> I am trying to plug a D-Link DWL-G122 802.11g wlan usb stick on to
OSK.
> But
> I always get the "over power budget" warning, should I modify the
power
> budget set in drivers/usb/host/ohci-omap.c?  Has anyone ever succeeded
to
> utilize a similar usb stick?
>
> And, I have tried to use a extra wire to get power supply from a PC
usb
> port, the errors were still.
>
> I am so eagerly looking forward to your help, thank you in advance.
>
> Best regards!
>
>
> Li Weichen
>
