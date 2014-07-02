From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Wed, 2 Jul 2014 05:29:25 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF8D33@DBDE04.ent.ti.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626104044.GJ28884@atomide.com> <20140626150615.GA15648@fox>
 <20980858CB6D3A4BAE95CA194937D5E73EAF8874@DBDE04.ent.ti.com>
 <20140701234219.GA27789@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60049 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaGBF36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 01:29:58 -0400
In-Reply-To: <20140701234219.GA27789@fox>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

>From: Guido Mart=EDnez [mailto:guido@vanguardiasur.com.ar]
>>On Tue, Jul 01, 2014 at 07:01:03AM +0000, Gupta, Pekon wrote:
>> >http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266=
966.html
>> >
>> I don't think we need above patch.
>> Helper macro "for_each_available_child_of_node" internally takes car=
e
>> of skipping nodes with status=3D"disabled".
>>
>> $KERNEL/include/linux/of.h
>> #define for_each_available_child_of_node(parent, child) \
>> 	for (child =3D of_get_next_available_child(parent, NULL); child !=3D=
 NULL; \
>> 	     child =3D of_get_next_available_child(parent, child))
>>
>> $KERNEL/drivers/of/base.c @@ of_get_next_available_child(...) {
>> 	...
>> 	if (!__of_device_is_available(next))
>> 			continue;
>> 	...
>Yes, that's why I suggest using that macro. It's not currently used
>in gpmc.c and my patch changes the 'for_each_child_of_node' to a
>'for_each_available_child_of_node'. Or am I missing something?
>
Oops my bad. I was probably dreaming, I already had your patch in my tr=
ee
before reviewing the code. So please ignore my previous email.

with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
