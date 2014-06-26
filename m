From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Thu, 26 Jun 2014 05:43:30 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF79CC@DBDE04.ent.ti.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140625152735.GA17792@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbaFZFoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 01:44:03 -0400
In-Reply-To: <20140625152735.GA17792@arch.cereza>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>

>From: Ezequiel Garcia [mailto:ezequiel@vanguardiasur.com.ar]
>>On 24 Jun 05:54 PM, Pekon Gupta wrote:
>> +&gpmc {
>> +	ranges = <0 0 0 0x01000000>;	/* address range = 16MB (minimum GPMC partition) */
>> +	nand@0,0 {
>> +		status = "disabled";
>> +		reg = <0 0 4>;		/* device IO registers */
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bbcape_nand_flash_pins>;
>> +		ti,nand-ecc-opt = "bch8";
>> +		ti,elm-id = <&elm>;
>
>Don't you need something like this to turn on the elm device?
>
>&elm {
>	status = "okay";
>};
>
No, This was the intend of these patches to keep cape DTS as "disabled"
so that:
(1)These patches should not change the behavior of existing DTS
 (am335x-boneblack.dts or am335x-bone.dts), or conflict with
 any existing node or other cape DTS.
(2) In-case of share-pin mux where multiple capes use same pins
Cape DTS should not conflict each other.

Now, to enable the choice of cape without hacking any source file,
user can use u-boot commands (refer to example in cover-letter):
/* load DTB */
u-boot> tftp 0x81000000 am335x-boneblack.dtb
u-boot> fdt addr 0x81000000
/* disabled conflicting MMC2 (eMMC) */
u-boot> fdt set  /ocp/mmc@481d8000 status \d\i\s\a\b\l\e\d
/* enable NAND cape*/
u-boot> fdt set  /ocp/elm status \o\k\a\y
u-boot> fdt set  /ocp/gpmc status \o\k\a\y
u-boot> fdt set  /ocp/gpmc/nand status \o\k\a\y

And then boot using this DTB loaded at 0x81000000
(you can put all these commands in uEnv as part of $bootcmd)


with regards, Pekon
