From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 02/14] omap: Map only available sram memory
Date: Mon, 4 Oct 2010 12:03:58 +0300
Message-ID: <AANLkTi=zmgSCCg71NsYMte9K-yeyb1i0VxCA4i_9Y8D-@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
	<20101001225303.GF3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57941 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0JDJD7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 05:03:59 -0400
Received: by qwh6 with SMTP id 6so2992311qwh.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 02:03:59 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE18C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

>> >
>> > This hangs OMAP3 pandora:
>> >
>> > [ =A0 =A00.000000] Linux version
>> > 2.6.36-rc6-next-20101001-00002-ge76bb53-dirty (notaz@pixelinis) (g=
cc
>> > version 4.3.3 (Sourcery G++ Lite 2009q1-20
>> > [ =A0 =A00.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARM=
v7),
>> cr=3D10c53c7f
>> > [ =A0 =A00.000000] CPU: VIPT nonaliasing data cache, VIPT nonalias=
ing
>> > instruction cache
>> > [ =A0 =A00.000000] Machine: Pandora Handheld Console
>> > [ =A0 =A00.000000] Ignoring unrecognised tag 0x54410008
>> > [ =A0 =A00.000000] bootconsole [earlycon0] enabled
>> > [ =A0 =A00.000000] Reserving 6422528 bytes SDRAM for VRAM
>> > [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeba=
ck
>> > [ =A0 =A00.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
>> > [ =A0 =A00.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 siz=
e: 0x10000
>> > (stuck here)
>> >
>> > reverting this fixes the problem.
>>
>> Hmm, boots fine here with overo. Any idea what in this patch breaks
>> pandora?
>>
> The change in this patch is not board dependent really. Have tested t=
his
> on 3430SDP. Pandora is OMAP3 based, right ?

OMAP3530 ES2.1, also tried on friend's beagleboard b5 (also ES2.1) and
it has the same problem. Maybe it's because of older Cortex A8 used
there, or I'm missing some errata workaround in defconfig.

BTW, hacking the size to 1M on top of your patch fixes the problem too:

        base =3D omap_sram_start;
        base =3D ROUND_DOWN(base, PAGE_SIZE);
        omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
-       omap_sram_io_desc[0].length =3D ROUND_DOWN(omap_sram_size, PAGE=
_SIZE);
+       omap_sram_io_desc[0].length =3D 0x100000;
        iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
