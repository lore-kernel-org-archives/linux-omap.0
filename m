From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Wed, 24 Dec 2014 13:53:46 +0200
Message-ID: <549AA94A.8030209@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com> <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59186 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbaLXLyA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Dec 2014 06:54:00 -0500
In-Reply-To: <20141223161936.GA9147@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/23/14 18:19, Felipe Balbi wrote:
> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
>> Hi Felipe,
>>
>> On 12/22/14 20:05, Felipe Balbi wrote:
>>
>> [...]
>>
>>>  CONFIG_SCSI_SCAN_ASYNC=y
>>> -CONFIG_ATA=y
>>> -CONFIG_SATA_AHCI_PLATFORM=y
>>> -CONFIG_MD=y
>>> +CONFIG_ATA=m
>>> +CONFIG_SATA_AHCI_PLATFORM=m
>>
>> Isn't this needed for the rootfs on SATA devices?
> 
> there's no known boards with rootfs on SATA. Until then, we can reduce
> the size.

What makes you say so?
The decision for rootfs on SATA is taken dynamically.
OMAP5 boards (specifically cm-t54) can have rootfs on SATA...

> 
>>>  CONFIG_NETDEVICES=y
>>>  # CONFIG_NET_VENDOR_ARC is not set
>>>  # CONFIG_NET_CADENCE is not set
>>> @@ -154,8 +151,8 @@ CONFIG_TI_CPSW=y
>>>  # CONFIG_NET_VENDOR_WIZNET is not set
>>>  CONFIG_AT803X_PHY=y
>>>  CONFIG_SMSC_PHY=y
>>> -CONFIG_USB_USBNET=y
>>> -CONFIG_USB_NET_SMSC95XX=y
>>> +CONFIG_USB_USBNET=m
>>> +CONFIG_USB_NET_SMSC95XX=m
>>
>> What about the NFS root for boards with only USB eth?
> 
> USB is a module already and it breaks PM when enabled.

Well, USB is not a module currently, but after reading below
I understand you mean HCDs are either disabled or modules.
Ok that's fine with me.

[...]

>>> -CONFIG_USB=y
>>> +CONFIG_HID_GENERIC=m
>>> +CONFIG_USB_HIDDEV=y
>>> +CONFIG_USB_KBD=m
>>> +CONFIG_USB_MOUSE=m
>>> +CONFIG_USB=m
>>
>> So, you don't consider USB a valid rootfs storage option?
> 
> read the original defconfig. This is *only* for usbcore.ko, EHCI is
> disabled, XHCI is a module, MUSB is disabled. What will you use for
> rootfs ?

Yes, thanks for pointing. Now I see indeed this is a sensible thing
to do and probably should have been done a while ago.

Might be worth addressing/explaining this in the commit message.

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUmqlKAAoJEBDE8YO64EfaifUQAIdwJFKPozpzVeKJjIYKQgzy
4axv2/Z2TBybF6dlxykrjWwUIX8e24bAtG8uyhnQ/l6NPWVqNqwM/DHALyPBgjMV
EXciALKHyx6DiHoeoTEhhCCocekI/fM9o0mqQHpqzp2M+/UAnHq2Px0pK6Cfk84y
RoyrunlOKOe1rZSbcgZKoZDuMV0qYK2ULpMl3c7QL5sPIGrkWIGe2eTil3/m6jvu
qDaVzGxsBmmCFVxMKv/cXysBd88cswg8sd2ptX7skgptB7lpSKRiAT69c3MXaJyM
zsbE4AE9fiYb0/aZO3hmmWlNp6OM1hxY/8IjL92Sydys/bXxDHQj1fePr9ofsFYM
vSohR6IOopv1xwr6PIKyL+brWJ0p07qKNWA5vrG21D/U0B6H/IPcSbneQtHnMkJl
jf6GccX5gG49MSTDWryFOtErsNXRf6Q5zaZGYTpEsDMXhCKTYJgBhoFX5i3fW4wH
kV/doXku38SAmwRBU0oLjNs07y1I0ijgBHLTtx3XZSd7fkM3CAWsToDapz7df+bx
FAi0+DZk3DVNhJoAeyaRauZQlLU//3McM2zFX8/11K9BP76n6OTanYnjVoJq0SNo
JIjEjmFMFtIF7Zke4JpUCkYlpcW17gQLfUCrcIW1WUq6i0TAGyILmDvZPgMp6+yk
bqMgzSs8ZRXyjqm6Uj7O
=UcBr
-----END PGP SIGNATURE-----
