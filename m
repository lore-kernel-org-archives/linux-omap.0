From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Tue, 1 Jul 2014 07:01:03 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF8874@DBDE04.ent.ti.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626104044.GJ28884@atomide.com> <20140626150615.GA15648@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53358 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaGAHBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 03:01:36 -0400
In-Reply-To: <20140626150615.GA15648@fox>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Guido,

>From: Guido Mart=EDnez
>>On Thu, Jun 26, 2014 at 03:40:44AM -0700, Tony Lindgren wrote:
>> * Pekon Gupta <pekon@ti.com> [140624 05:26]:
>> > +
>> > +&gpmc {
>> > +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimu=
m GPMC partition) */
>> > +	nand@0,0 {
>> > +		status =3D "disabled";
>> > +		reg =3D <0 0 4>;		/* device IO registers */
>>
>> Hmm so what about other capes potentially also using GPMC CS0?
>>
>> Can you please do a check with two .dtsi files trying to use
>> GPMC CS0 and see what the produced .dtb file looks like after
>> decompiling it with dtc?
>>
>> I'd assume the 16MB GPMC partition will be just fine for many
>> devices and can be also be larger if NOR needs it so maybe it
>> can be handled for almost all the cases.
>>
>> The names for devices must be unique though to avoid them
>> getting merged. And I don't know if gpmc.c skips disabled devices
>> properly.
>It doesn't. I've just sent a patch for it.
>
>http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266966=
=2Ehtml
>
I don't think we need above patch.
Helper macro "for_each_available_child_of_node" internally takes care
of skipping nodes with status=3D"disabled".

$KERNEL/include/linux/of.h
#define for_each_available_child_of_node(parent, child) \
	for (child =3D of_get_next_available_child(parent, NULL); child !=3D N=
ULL; \
	     child =3D of_get_next_available_child(parent, child))

$KERNEL/drivers/of/base.c @@ of_get_next_available_child(...) {
	...
	if (!__of_device_is_available(next))
			continue;
	...


with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
