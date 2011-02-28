From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to	omap_display
Date: Mon, 28 Feb 2011 15:55:00 +0100
Message-ID: <4D6BB744.1010205@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com> <1295850125-21405-6-git-send-email-sumit.semwal@ti.com> <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari> <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari> <4D6B88BB.5010200@ti.com> <1298895026.9809.27.camel@deskari> <20110228121321.GB30781@n2100.arm.linux.org.uk> <4D6BA558.5050700@ti.com> <20110228140617.GA2176@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48575 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab1B1OzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:55:12 -0500
In-Reply-To: <20110228140617.GA2176@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/28/2011 3:06 PM, Russell King - ARM Linux wrote:
> On Mon, Feb 28, 2011 at 02:38:32PM +0100, Cousson, Benoit wrote:
>> On 2/28/2011 1:13 PM, Russell King - ARM Linux wrote:
>>> On Mon, Feb 28, 2011 at 02:10:26PM +0200, Tomi Valkeinen wrote:
>>>> On Mon, 2011-02-28 at 05:36 -0600, Cousson, Benoit wrote:
>>>>> Cannot you use a device hierarchy then to do that?
>>>>>     omap_dss/core
>>>>>     omap_dss/dsi
>>>>>     omap_dss/venc
>>>>>
>>>>> This is moreover the way the HW is done.
>>>>
>>>> Hmm, how would that work? The devices are platform devices, and th=
ey
>>>> have a unique global name, which is used to match the driver for t=
he
>>>> device.
>>>
>>> And not forgetting that '/' is not permitted in device or driver na=
mes.
>>
>> I was not really considering naming the device with a '/'. The idea =
is
>> that the devices will not longer be flat platform devices but someth=
ing
>> like dss devices that will have have a omap_dss parent.
>>
>> I do not know if that makes sense to store some kind of hierarchy in=
 the
>> device model, but encoding the hierarchy in the name like it is prop=
osed
>> looks like a hack to me.
>=20
> Try:
>=20
> tree -d /sys/devices/pci0000\:00
>=20
> on your PC, taking special note of how pci-to-pci bridges are handled=
=2E

Here it is, but I'm not sure to understand how it is really done :-(

/sys/devices/pci0000:00
=E2=94=9C=E2=94=80=E2=94=80 0000:00:00.0
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 firmware_node -> ../../LNXSYSTM=
:00/LNXSYBUS:00/PNP0A08:00/PNP0C02:00
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../../bus/pci
=E2=94=9C=E2=94=80=E2=94=80 0000:00:02.0
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:00:02.0:pcie01
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../=
=2E./../bus/pci_express
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:00:02.0:pcie02
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 driver -> ../../../=
=2E./bus/pci_express/drivers/aer
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../=
=2E./../bus/pci_express
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:06:00.0
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:06:00.0:pcie12
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsyst=
em -> ../../../../../bus/pci_express
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:07:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:07=
:00.0:pcie22
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=
=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../bus/pci_express
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000:08=
:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=
=80 0000:09:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=
=94=80=E2=94=80 driver -> ../../../../../../../bus/pci/drivers/bnx2
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=
=94=80=E2=94=80 net
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82  =
 =E2=94=94=E2=94=80=E2=94=80 eth1
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82  =
     =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../0000:09:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82  =
     =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82  =
     =E2=94=9C=E2=94=80=E2=94=80 statistics
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82  =
     =E2=94=94=E2=94=80=E2=94=80 subsystem -> ../../../../../../../../.=
=2E/class/net
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=
=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=
=94=80=E2=94=80 subsystem -> ../../../../../../../bus/pci
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=
=80 pci_bus
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=
=94=80=E2=94=80 0000:09
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=9C=
=E2=94=80=E2=94=80 device -> ../../../0000:08:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=9C=
=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=94=
=E2=94=80=E2=94=80 subsystem -> ../../../../../../../../class/pci_bus
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=
=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../bus/pci
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 driver =
-> ../../../../../bus/pci/drivers/pcieport
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 pci_bus
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=
=80 0000:08
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=9C=E2=94=80=E2=
=94=80 device -> ../../../0000:07:00.0
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=9C=E2=94=80=E2=
=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82       =E2=94=94=E2=94=80=E2=
=94=80 subsystem -> ../../../../../../../class/pci_bus
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 subsyst=
em -> ../../../../../bus/pci
=2E..

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
