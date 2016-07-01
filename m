From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET is 'm'
Date: Fri, 01 Jul 2016 12:41:43 +0300
Message-ID: <8737ntofu0.fsf@linux.intel.com>
References: <1467276056-19357-1-git-send-email-rogerq@ti.com> <8760srgf00.fsf@linux.intel.com> <577525BF.3060509@ti.com> <878txloknc.fsf@linux.intel.com> <57762591.8010703@ti.com> <8760spojty.fsf@linux.intel.com> <57762999.8040906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57762999.8040906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: stern@rowland.harvard.edu, sre@kernel.org, peter.chen@nxp.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>>>> NOP_USB_XCEIV is used not only by gadget drivers but by
>>>>>>> host drivers as well e.g. EHCI_OMAP.
>>>>>>>
>>>>>>> commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc=
-core")
>>>>>>> made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm=
'.
>>>>>>> But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.
>>>>>>>
>>>>>>> Fix this undesired behaviour by moving usb_gadget_vbus_connect/disc=
onnect()
>>>>>>> to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
>>>>>>> on USB_GADGET.
>>>>>>>
>>>>>>> Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
>>>>>>> by drivers that need it.
>>>>>>
>>>>>> no, this is the wrong way to fix this. NOP _has_ a dependency on the
>>>>>> Gadget API if it calls Gadget API functions. Dependencies are proper.
>>>>>>
>>>>>> Maybe the reason for the problem is that we ended up adding far too =
much
>>>>>> code to phy-generic.c itself. Maybe it shouldn't know about clks and
>>>>>> interrupts. The original idea of that driver was to simply satisfy a
>>>>>> requirement to have a valid transceiver by some platforms. Maybe we
>>>>>> should fix that instead. Moving functions around to workaround a pro=
blem
>>>>>> is not the way to go, sorry.
>>>>>>
>>>>> OK but something that was working all these years is broken by your
>>>>> patch.
>>>>> Do you mind fixing it please? Or at least let me know how you want to
>>>>> get it fixed.
>>>>
>>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>>> index 2e710a4cca52..89fd095ca33d 100644
>>>> --- a/drivers/usb/host/Kconfig
>>>> +++ b/drivers/usb/host/Kconfig
>>>> @@ -180,7 +180,7 @@ config USB_EHCI_MXC
>>>>  config USB_EHCI_HCD_OMAP
>>>>         tristate "EHCI support for OMAP3 and later chips"
>>>>         depends on ARCH_OMAP
>>>> -       depends on NOP_USB_XCEIV
>>>> +       depends on USB_PHY
>>>>         default y
>>>>         ---help---
>>>>           Enables support for the on-chip EHCI controller on
>>>>
>>>>
>>> This doesn't fix the real problem. i.e. we can't have NFS root on panda=
board
>>> and omap5_uevm because network device is on USB EHCI, unless we have
>>> both USB_GADGET and NOP_USB_XCEVI built-in, which is not really that
>>> desirable.
>>=20
>> Well, NOP calls a symbol that belongs to the Gadget API. So NOP cannot
>> be built-in if gadget API is a module. Satisfy the dependencies and
>> everything will work for you.
>>=20
>> Don't get me wrong, I see what you mean; but you _are_ relying in a
>> driver that calls into the Gadget API. Consider if it was the other way
>> around: say NOP was calling something from usbcore for whatever reason
>> and MUSB depended on NOP. You wouldn't have MUSB built-in unless NOP and
>> usbcore were also built-in, right?
>>=20
> I agree with you. As far as EHCI_OMAP is concerned we're only interested
> in configuring the PHY clocks and issuing a GPIO reset.
> As of now because of dependency issues with GADGET, NOP_USB_XCEIV doesn't
> seem to be the right place. I'm OK with using some other driver
> that doesn't have such dependency, even if it breaks DT compatibility with
> some OMAP boards. Or I'll just let EHCI_OMAP do it all by itself.
>
> Unless Tony has any objections.

I don't have memory of why EHCI-omap is using PHY, actually. Is it
really resetting a PHY?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdjrXAAoJEIaOsuA1yqREUDYQAIlKqTRWgNX9ZKHwgzuU9+O4
UuZFPhc6y8mx41OT6YIvulHiRZlQrNPh8Gq8XybQ2LL9JDV5xLcke+RNNAVTyhS3
//H4gjuDQWLIanS6fbyePKbT0ZlvHJa3o8A6127NpePN7PijJYRUwbCReXyN0MaQ
6PSwVA2y7nkZPd9+zWNTGtc3sa+NzX2dc/M28w6Zjsuw8YudjCmCIEjwq44GVLYa
IpBEy+YJmJqMXwBZckbk/zC3fYWBE+X0E9zBBLtfnkuwbtmhOybuhf5Vc8ItZLdc
NrRmf+v3q84AcdOgN/2o70wWg2bX1rKQri7+NEhQMcs45OeeKFdd7z6bzglPoRqt
rtpbpG2lOe9RG5LONpQa4vASK9ygUL/oQFDtHeVpWlhSFmAY/2RrA5NkkFa25rnS
8felf9r5DRwycZgbBtPHEVp6BGGKLIMdiOGVdrYXC2dTH36WoiEdGTnDV+FE8SnZ
BJXW17NrokfdA6lWyRD5nyeQu8fRMYtdWwXkpsDhW3wt3kT87Nc8aJiTLRPDkNne
ela+6fQ3xcKCkfSB4hNKmqB0VLm4rvkgbxd56DtOymxaLy/ntl1IYQdAVA85KzkI
Q2tGguEFqRm3XZb5g3yC2a1mQF6xjLlYbDyG6fv94uuc706YXvGnQS+ij2xvaFG3
MBpXKX0ci85BJfFQ8aXZ
=pKVk
-----END PGP SIGNATURE-----
--=-=-=--
