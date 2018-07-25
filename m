From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
Date: Wed, 25 Jul 2018 14:27:31 +0200
Message-ID: <85BC9F70-2E58-4915-9405-7CC1855975C4@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com> <20180725080735.GA7467@lenoch> <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com> <20180725083305.GB8303@lenoch>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725083305.GB8303@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


> Am 25.07.2018 um 10:33 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
>>=20
>>> Am 25.07.2018 um 10:07 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>=20
>>> On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller =
wrote:
>>>> Vendor defined U-Boot has changed the partition scheme a while ago:
>>>>=20
>>>> * kernel partition 6MB
>>>> * file system partition uses the remainder up to end of the NAND
>>>> * increased size of the environment partition (to get an OneNAND =
compatible base address)
>>>> * shrink the U-Boot partition
>>>>=20
>>>> Let's be compatible (e.g. Debian kernel built from upstream).
>>>=20
>>> That, in fact, is breaking compatibility.
>>=20
>> With what? Nobody is using the old u-boot partition scheme any more
>> (it is >5 years old).
>>=20
>>> So once you are touching this
>>> what about relying on partitioning provided by bootloader just to =
prevent
>>> something like this happening again?
>>=20
>> Well, we define what compatible means here (since we are the vendor).
>> And people complain with us. We simply recommend them to upgrade the
>> boot-loader.
>=20
> Fair enough. Suggestion was to remove partitioning scheme from DTB =
alltogether
> and let U-Boot provide one. But you being vendor you decide, of course =
:)
> (I'd use only two partitions: MLO and UBI, latter one with BCH8, and =
store
> everything in UBI volumes. That's a bit more flexible approach)

Yes, that is a good goal for a future setup and would of course be =
better.
Like U-Boot already provides the memory layout for RAM.

Hopefully, someone will work out patches for u-boot plus kernel (which =
is always
painful to keep these two in sync and tested). But I don't want to do =
that now.

BR and thanks,
Nikolaus
