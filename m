From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init() visible to board code
Date: Tue, 15 May 2012 11:13:42 -0700
Message-ID: <87zk99jort.fsf@ti.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
	<CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
	<CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
	<20120508231653.GP5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43971 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932910Ab2EOSNm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 14:13:42 -0400
Received: by dady13 with SMTP id y13so11136442dad.33
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 11:13:41 -0700 (PDT)
In-Reply-To: <20120508231653.GP5088@atomide.com> (Tony Lindgren's message of
	"Tue, 8 May 2012 16:16:54 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Enric =?utf-8?Q?Balle?= =?utf-8?Q?tb=C3=B2?= i Serra <eballetbo@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

Tony Lindgren <tony@atomide.com> writes:

> * Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
>> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb=C3=B2 i Serra
>> <eballetbo@gmail.com> wrote:
>> >
>> > Tony, as this is a fix ,may be included ?
>> >
>> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> >
>> > Cheers,
>> > =C2=A0 =C2=A0Enric
>>=20
>> Hi Tony, Russel:
>>=20
>> This patch is a requirement for patch:
>>=20
>> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flas=
h
>> storage memory
>>=20
>> which is really important since newer IGEPv2 boards have changed the=
ir
>> flash memory from OneNAND to NAND.
>>=20
>> This patch-set is necessary to make the board work, otherwise it
>> doesn't even boot.
>>=20
>> Could we please include these patches?
>
> Thanks for the patience, applying now into board branch finally.

This patch breaks the build for platforms that don't use ONENAND.
Using omap2plus_defconfig, set CONFIG_MTD_ONENAND_OMAP2=3Dn and you'll =
get
the build error below[1]

By removing the static, there is now duplicate definitions in the .c an=
d
=2Eh files.

The solution is to remove the dummy definition from the .c file. =20

Tony, feel free to fold the diff below[2] into the original patch to fi=
x
this compile problem.

Kevin


[1]
/work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.c:102:111: error:=
 redefinition of 'board_onenand_init'
/work/kernel/omap/dev/arch/arm/mach-omap2/board-flash.h:56:51: note: pr=
evious definition of 'board_onenand_init' was here
make[2]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/mach-omap2] Error 2
make: *** [sub-make] Error 2

[2]
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/bo=
ard-flash.c
index 70a81f9..53c39d2 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -97,11 +97,6 @@ __init board_onenand_init(struct mtd_partition *onen=
and_parts,
=20
 	gpmc_onenand_init(&board_onenand_data);
 }
-#else
-void
-__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts=
, u8 cs)
-{
-}
 #endif /* CONFIG_MTD_ONENAND_OMAP2 || CONFIG_MTD_ONENAND_OMAP2_MODULE =
*/
=20
 #if defined(CONFIG_MTD_NAND_OMAP2) || \
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
