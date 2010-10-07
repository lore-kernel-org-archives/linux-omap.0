From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: Issue : jffs2 and ecc layout
Date: Thu, 7 Oct 2010 23:01:36 +0530
Message-ID: <AANLkTi=y1JwSBrELd=KyUsmhitSCF2eWW9iYFg3a_-J4@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0356594397@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49111 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0JGRb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 13:31:58 -0400
Received: by qyk29 with SMTP id 29so332050qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 07 Oct 2010 10:31:58 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356594397@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 4, 2010 at 12:59 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Ghorai, Sukumar
>> Sent: Tuesday, September 28, 2010 6:17 PM
>> To: linux-mtd@lists.infradead.org
>> Cc: linux-omap@vger.kernel.org
>> Subject: Issue : jffs2 and ecc layout
>>
>> Hi,
>> I was using the following ecc layout which is not working to mount t=
he
>> jffs2 File-system. I was in 2.6.32 kernel and working; but same layo=
ut is
>> not working with latest 2.6 kernel.
>>
>> Observation is that - no read request issued to the driver (say omap=
2.c).
>>
>> # mount -t jffs2 /dev/mtdblock4 /mnt/nand
>> [=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested 8 b=
ytes, read
>> 0 bytes, error -22
>> mount: Mounting /dev/mtdblock4 on /mnt/nand failed: Input/output err=
or
>>
>> # dmesg
>> <3>[=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested =
8 bytes,
>> read 0 bytes, error -22
>>
I do not think above issue has anything to do with the ECC layout.
But as I earlier pointed (in [1]), this change [2] has messed up
function 'omap_hwcontrol'.
All read/write functions read/write data from/to address
info->nand.IO_ADDR_(R/W), which is not set by new function
'gpmc_nand_write' (which still take care of writing address/cmd to
write registers). But since above pointer is not set (hence points to
address '0'), driver tries to read data from wrong location.

In fact, I would even suggest to try dumping nand command registers(or
use T32) and verify if commands issued were written correctly to
appropriate registers.



[1]: http://marc.info/?l=3Dlinux-omap&m=3D128302624528822&w=3D2
[2] commit: http://git.infradead.org/mtd-2.6.git/commitdiff/2c01946c6b9=
ebaa5a89710bc42ca224a7f52f227

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
