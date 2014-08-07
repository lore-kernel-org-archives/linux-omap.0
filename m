From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/3] mtd: nand: omap: Revert to using software ECC by
 default
Date: Thu, 7 Aug 2014 11:43:18 +0300
Message-ID: <53E33C26.10100@ti.com>
References: <1407233482-11642-1-git-send-email-rogerq@ti.com>	<1407233482-11642-2-git-send-email-rogerq@ti.com>	<CANOLnOM-Q4b8N5T522Vc_gXTSj2C-mxV6GV0hRTDPscpPgXO6A@mail.gmail.com>	<53E1E122.4050308@ti.com> <CANOLnOOA5c-B9rn5LR2HGyfUW+D1UzjRE7EAL-cYsZ4NYuCaXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43858 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbaHGIn7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Aug 2014 04:43:59 -0400
In-Reply-To: <CANOLnOOA5c-B9rn5LR2HGyfUW+D1UzjRE7EAL-cYsZ4NYuCaXg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, pekon.gupta@gmail.com, artem.bityutskiy@linux.intel.com, dwmw2@infradead.org, jg1.han@samsung.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 08/07/2014 01:55 AM, Grazvydas Ignotas wrote:
> On Wed, Aug 6, 2014 at 11:02 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi Gra=C5=BEvydas,
>>
>> On 08/05/2014 07:15 PM, Grazvydas Ignotas wrote:
>>> On Tue, Aug 5, 2014 at 1:11 PM, Roger Quadros <rogerq@ti.com> wrote=
:
>>>> For v3.12 and prior, 1-bit Hamming code ECC via software was the
>>>> default choice. Commit c66d039197e4 in v3.13 changed the behaviour
>>>> to use 1-bit Hamming code via Hardware using a different ECC layou=
t
>>>> i.e. (ROM code layout) than what is used by software ECC.
>>>>
>>>> This ECC layout change causes NAND filesystems created in v3.12
>>>> and prior to be unusable in v3.13 and later. So revert back to
>>>> using software ECC by default if an ECC scheme is not explicitely
>>>> specified.
>>>>
>>>> This defect can be observed on the following boards during legacy =
boot
>>>>
>>>> -omap3beagle
>>>> -omap3touchbook
>>>> -overo
>>>> -am3517crane
>>>> -devkit8000
>>>> -ldp
>>>> -3430sdp
>>>
>>> omap3pandora is also using sw ecc, with ubifs. Some time ago I trie=
d
>>> booting mainline (I think it was 3.14) with rootfs on NAND, and whi=
le
>>> it did boot and reached a shell, there were lots of ubifs errors, f=
s
>>> got corrupted and I lost all my data. I used to be able to boot
>>> mainline this way fine sometime ~3.8 release. It's interesting that
>>> 3.14 was able to read the data, even with wrong ecc setup.
>>
>> This is due to another bug introduced in 3.7 by commit 65b97cf6b8dec=
a3ad7a3e00e8316bb89617190fb.
>> Because of that bug (i.e. inverted CS_MASK in omap_calculate_ecc), o=
map_calculate_ecc() always fails with -EINVAL and calculated ECC bytes =
are always 0. I'll be sending a patch to fix that as well. But that wil=
l only affect the cases where OMAP_ECC_HAM1_CODE_HW is used which happe=
ned for pandora from 3.13 onwards.
>>
>>>
>>> Do you think it's safe again to boot ubifs created on 3.2 after
>>> applying this series?
>>>
>>
>> Yes. If you boot pandora using legacy boot (non DT method), it passe=
s 0 for .ecc_opt in pandora_nand_data. This used to mean OMAP_ECC_HAMMI=
NG_CODE_DEFAULT which is software ecc. i.e. NAND_ECC_SOFT with default =
ECC layout. Until the above mentioned commits changed the meaning. We n=
ow call that option OMAP_ECC_HAM1_CODE_SW.
>>
>> Please let me know if it works for you. Thanks.
>=20
> Yes it does, thank you.
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>=20
> Found something new in dmesg though:
> [    1.542755] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x=
bc
> [    1.549621] nand: Micron MT29F4G16ABBDA3W
> [    1.553894] nand: 512MiB, SLC, page size: 2048, OOB size: 64
> [    1.560058] nand: WARNING: omap2-nand.0: the ECC used on your
> system is too weak compared to the one required by the NAND chip
>=20
> Do you think it's best to migrate to different ECC scheme? It would b=
e
> better to avoid that so that users can freely change kernels and the
> bootloader wouldn't have to be changed..
>=20
I'm not sure why these boards were using Software ECC scheme in the fir=
st place.
So moving to a better ECC scheme should be considered with a warning th=
at backward
compatibility will be broken.

There is a limitation with the OMAP3 ROM code loader. So if you want un=
iform ECC scheme
for MLO, u-boot and kernel partitions then we are limited to Hamming co=
de for SLC NAND with
512B, 2KB and 4KB pages.

=46or MLC NAND, the ROM code uses a proprietary layout using checksum a=
nd BCH and I'm not very sure
if this is compatible with the newer OMAP platforms and AM33xx platform=
s.

=46or details see OMAP35x TRM. (spruf98y.pdf)
http://www.ti.com/lit/ug/spruf98y/spruf98y.pdf
sections
25.4.7.4.2 SLC NAND Read Sector Procedure
25.4.7.4.3 MLC NAND Read Sector Procedure

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
