From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Tue, 1 Jul 2014 20:42:19 -0300
Message-ID: <20140701234219.GA27789@fox>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626104044.GJ28884@atomide.com>
 <20140626150615.GA15648@fox>
 <20980858CB6D3A4BAE95CA194937D5E73EAF8874@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:46282 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbaGAXjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 19:39:53 -0400
Received: by mail-yk0-f177.google.com with SMTP id 10so6081812ykt.36
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2014 16:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF8874@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Pekon,

On Tue, Jul 01, 2014 at 07:01:03AM +0000, Gupta, Pekon wrote:
> >http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/2669=
66.html
> >
> I don't think we need above patch.
> Helper macro "for_each_available_child_of_node" internally takes care
> of skipping nodes with status=3D"disabled".
>=20
> $KERNEL/include/linux/of.h
> #define for_each_available_child_of_node(parent, child) \
> 	for (child =3D of_get_next_available_child(parent, NULL); child !=3D=
 NULL; \
> 	     child =3D of_get_next_available_child(parent, child))
>=20
> $KERNEL/drivers/of/base.c @@ of_get_next_available_child(...) {
> 	...
> 	if (!__of_device_is_available(next))
> 			continue;
> 	...
Yes, that's why I suggest using that macro. It's not currently used
in gpmc.c and my patch changes the 'for_each_child_of_node' to a
'for_each_available_child_of_node'. Or am I missing something?

Regards,

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
