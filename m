From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Fri, 27 Jun 2014 21:06:54 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF8248@DBDE04.ent.ti.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com> <20140626194824.GA18814@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbaF0VH0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 17:07:26 -0400
In-Reply-To: <20140626194824.GA18814@fox>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

>From: Guido Mart=EDnez [mailto:guido@vanguardiasur.com.ar]
>>On Tue, Jun 24, 2014 at 05:54:24PM +0530, Pekon Gupta wrote:

[...]

>> +&gpmc {
>> +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimum =
GPMC partition) */
>> +	nand@0,0 {
>> +		status =3D "disabled";
>> +		reg =3D <0 0 4>;		/* device IO registers */
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&bbcape_nand_flash_pins>;
>This doesn't seem to work as pinctrl properties are not parsed for
>childs of the gpmc node. Did this work for you?
>Putting this in the gpmc node makes it work, but how will we control
>pins for the nand and nor independently? I believe there is currently =
no
>support for muxing individual gpmc devices. If we want to add both
>devices to the DT and enable them as needed we'd need to add support f=
or
>this, right?
>
Yes, And that should be the case, because different devices would be
connected to different chip-selects, so there should be support of
providing individual pin-mux for different GPMC devices.

Currently both NAND and NOR cape share GPMC_CS0, so both NAND and NOR
capes will not work simultaneously. But I'm planning to modify NOR cape
hardware at my end to use GPMC_CS1 instead of GPMC_CS0.
- NAND on GPMC_CS0
- NOR on GPMC_CS1
In addition to pin-mux you may also require following patch:
http://www.spinics.net/lists/linux-omap/msg107950.html

Also, I should have marked this series as RFC as its not fully tested.
My main intention was to get acknowledgement about cape DTS from
various users and Tony Lindgren <tony@atomide.com>.
Now as Tony has given some acceptance for these kind of cape DTS,
I'll clean-up and re-send these patches with better testing and GPMC fi=
xes.


with regards, pekon


with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
