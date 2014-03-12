From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Wed, 12 Mar 2014 12:28:50 -0700
Message-ID: <20140312192850.GF1996@atomide.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
 <1394621360-2457-2-git-send-email-pekon@ti.com>
 <532070C8.1030903@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
 <CAGo_u6rvUqa-7afTFzBahDJuyVkXAj5J2LL8tQRjZuf8_xWXWA@mail.gmail.com>
 <CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48871 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751865AbaCLT24 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 15:28:56 -0400
Content-Disposition: inline
In-Reply-To: <CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "Gupta, Pekon" <pekon@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

* Robert Nelson <robertcnelson@gmail.com> [140312 12:11]:
> On Wed, Mar 12, 2014 at 1:57 PM, Nishanth Menon <nm@ti.com> wrote:
> > On Wed, Mar 12, 2014 at 1:26 PM, Gupta, Pekon <pekon@ti.com> wrote:
> >> Hi,
> >>
> >>>From: Menon, Nishanth
> >>>>On 03/12/2014 05:49 AM, Pekon Gupta wrote:
> >>>> Beaglebone Board can be connected to expansion boards to add devices to them.
> >>>> These expansion boards are called 'capes'. This patch adds support for
> >>>> following versions of Beaglebone(AM335x) NAND capes
> >>>> (a) NAND Device with bus-width=16, block-size=128k, page-size=2k, oob-size=64
> >>>> (b) NAND Device with bus-width=16, block-size=256k, page-size=4k, oob-size=224
> >>>> Further information and datasheets can be found at [1] and [2]
> >> [...]
> >>>> [1] http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
> >>>> [2] http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
> >>>>
> >>>> Signed-off-by: Pekon Gupta <pekon@ti.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/am335x-bone.dts | 123 ++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 123 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> >>>> index 94ee427..be2c572 100644
> >>>> --- a/arch/arm/boot/dts/am335x-bone.dts
> >>>> +++ b/arch/arm/boot/dts/am335x-bone.dts
> >>>
> >>>better to make a nand_cape dts which includes the am335x-bone.dts?
> >>>
> >> Actually, I'm not in favor of having too many "xx_board_common.dts" files,
> >> because it un-necessarily complexes things.
> >>
> >> We already have "arch/arm/boot/dts/am335x-bone-common.dtsi" which just saves
> >> some lines common to DTS of both Beaglebone-LT(white) and Beaglebone-Black.
> >> And, there is no guarantee that Beaglebone-LT(white) will remain compatible to
> >> Beaglebone-black in future.
> >> Example: some capes are not compatible to beaglebone-black [1], [2].
> >>
> >> So, I prefer to keep separate GPMC NAND nodes separately in both DTS,
> >> unless there is a strong convincing reason otherwise.
> >>
> >>
> >> [1] http://elinux.org/CircuitCo:BeagleBoardToys
> >> [2] http://elinux.org/BeagleBone_Black_Capes
> >
> >
> >
> > Right, and adding NAND, GPMC nodes and asking folks to uncomment
> > sections into a generic board file (which by default has none) makes
> > more sense? I dont use NAND capes or might create my own cape. overo
> > has the same challenges as bone family has.I dont see asking folks to
> > uncomment entries to use the cape is a nicer alternative to having
> > more dts entries.
> 
> This is just going to get more messy with every cape addition. Should
> we maybe just leave a basic BeagleBone & BeagleBone Black dts file in
> mainline kernel.org.
> 
> Then create a repo on github.com/beagleboard/ with every
> <bone/black>-<first level cape>.dts option?

Or just include all devices on the most common capes but have their
status as disabled by default.

For the pinctrl, we need to make sure the pins for a device are not
muxed if it's set to disabled state.

Regards,

Tony
