From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 0/3] nand: Renaming, moving and fixing NAND and ELM drivers
Date: Fri, 12 Sep 2014 17:46:37 +0100
Message-ID: <CAAEAJfCJNN_rOm7dp1crohuD7or1D7RN3bLqu6WzLW32goX8kA@mail.gmail.com>
References: <1410443224-18477-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<5412B4C0.505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:58721 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaILQqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 12:46:38 -0400
Received: by mail-yh0-f52.google.com with SMTP id f73so574664yha.25
        for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2014 09:46:37 -0700 (PDT)
In-Reply-To: <5412B4C0.505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On 12 September 2014 09:54, Roger Quadros <rogerq@ti.com> wrote:
> Hi Ezequiel,
>
> On 09/11/2014 04:47 PM, Ezequiel Garcia wrote:
>> Following the recent discussion with Roger, here's a few patches tha=
t
>> (hopefully) fix all the issues.
>>
>> The first patches rename the OMAP NAND drivers, so they are now call=
ed
>> omap2_nand and omap_elm.
>>
>> The last patch picks an idea from Yann E. Morin and fixes the build =
issue
>> reported by Roger. Quoting Roger:
>>
>> ""
>> I still get the following error if I set CONFIG_MTD_NAND_OMAP2 to y =
and
>> CONFIG_MTD_NAND_OMAP_BCH to m.
>>
>> CONFIG_MTD_NAND_OMAP_BCH is used to select the ELM driver and it mus=
t be limited to
>> be built-in if CONFIG_MTD_NAND_OMAP2 is built-in.
>>
>> Maybe it should be a sub option of CONFIG_MTD_NAND_OMAP2.
>> IMHO the elm.c file must be moved from mtd/devices to mtd/nand and r=
enamed to omap_elm.c
>>
>> drivers/built-in.o: In function `omap_nand_probe':
>> /work/linux-2.6/drivers/mtd/nand/omap2.c:2010: undefined reference t=
o `elm_config'
>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1980: undefined reference t=
o `elm_config'
>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1927: undefined reference t=
o `elm_config'
>> drivers/built-in.o: In function `omap_elm_correct_data':
>> /work/linux-2.6/drivers/mtd/nand/omap2.c:1444: undefined reference t=
o `elm_decode_bch_error_page'
>> make: *** [vmlinux] Error 1
>> ""
>>
>> [1] https://lkml.org/lkml/2013/5/4/84
>>
>> Ezequiel Garcia (3):
>>   mtd: nand: Move ELM driver and rename as omap_elm
>>   mtd: nand: Rename OMAP NAND driver
>>   mtd: nand: Force omap_elm to be built as a module if omap2_nand is=
 a
>>     module
>
> Thanks for the patches. I see a lot of errors reported by checkpatch.=
pl which need fixing.
>

You mean on these patches or across the file?

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
