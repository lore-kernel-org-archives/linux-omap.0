From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/3] ARM: dts: Add headers with constants for MTD partitions
Date: Wed, 19 Jun 2013 11:19:45 +0200
Message-ID: <51C177B1.7010609@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch> <1370962138-9631-2-git-send-email-florian.vaussard@epfl.ch> <20130612130511.CE3D93E0A56@localhost>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:36485 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933820Ab3FSJTz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 05:19:55 -0400
In-Reply-To: <20130612130511.CE3D93E0A56@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>

Hello,

Thank you for the review.

On 06/12/2013 03:05 PM, Grant Likely wrote:
> On Tue, 11 Jun 2013 16:48:56 +0200, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
>> These constants can be used to easily declare MTD partitions inside
>> DTS.
>>
>> The constants MTDPART_OFS_* are purposely not included. Indeed,
>> parse_ofpart_partitions() is expecting u64, but a DT cell is u32.
>> Negative constants, as defined by MTDPART_OFS_*, would be wrongly
>
> The DT binding uses the number of cells defined by #address-cells. It is
> not fixed to a u32 or a u64
>

The message was ill-formatted, sorry. As an address cell is u32, and as
parse_ofpart_partitions() is storing the value inside u64 without checking
for sign extension (as one assumes to have only positive offsets),
passing a negative value would require 2 address cells, making it more 
difficult
for the DT user. But as Stephen Warren noticed, it is probably desirable
to specify sizes >= 4GB, thus I will think about a way to easily handle 
such case.

Anyway, MTDPART_OFS_* would probably face the same objection raised by 
you for
MTDPART_SIZ_FULL.

>> interpreted by parse_ofpart_partitions(). Two cells should be
>> used to correctly encode the negative constants, but this breaks
>> current usage.
>
> The binding doesn't even allow for shortcuts like MTDPART_SIZ_FULL. If a
> partition fills the whole device, then the reg property should include
> the actual size. If the code is allowing '0' to be used to mean
> MTDPART_SIZ_FULL, then that is a bug that needs to be fixed.
>

The root problem is that many System on Module, like the Gumstix Overo, are
shipped with various NAND sizes depending on the version or even the 
manufacturing
period. Supporting such a diversity would painfully duplicates lots of DT
code and clutter the arch/arm/boot/dts/ directory with dozens of slightly-
different versions. I believe that determining the NAND size is better done
at probe time, and this is what is currently done in legacy board files:

static struct mtd_partition overo_nand_partitions[] = {
         {
                 .name           = "xloader",
                 .offset         = 0,                    /* Offset = 
0x00000 */
                 .size           = 4 * NAND_BLOCK_SIZE,
                 .mask_flags     = MTD_WRITEABLE
         },

<snip...>

         {
                 .name           = "rootfs",
                 .offset         = MTDPART_OFS_APPEND,   /* Offset = 
0x680000 */
                 .size           = MTDPART_SIZ_FULL,
         },
};

Moreover, I do not see such strict restriction in the OF norm. If I 
refer to IEEE
1275-1994 page 174, for the definition of the "reg" property, it is written:

"The interpretation of the size entries is dependent on the parent bus."

Nevertheless, if such an approach is not acceptable, could we think about an
alternative solution? Like a boolean property "mtd,append-and-fill" that 
would
replace the "reg" property and tell the MTD core to compute the 
partition size
at probe time, like what is currently done with board files?

Best regards,

Florian
