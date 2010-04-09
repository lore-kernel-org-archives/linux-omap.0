From: "Jerry Johns" <Jerry.Johns@nuvation.com>
Subject: OMAP35xx Boot failure
Date: Fri, 9 Apr 2010 08:33:20 -0700
Message-ID: <274F7B50569A1B4C9D7BCAB17A9C7BE102216BC8@mailguy3.skynet.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.nuvation.com ([68.65.78.147]:21393 "EHLO
	mailguy3.skynet.nuvation.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754140Ab0DIPdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Apr 2010 11:33:21 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,=20
        =A0=A0=A0 I've got a custom OMAP3503 board with 256Mbytes of LP=
DDR memory (single die, x32-bit) that i've got working with x-loader an=
d u-
boot. However, when i load the Linux kernel (2.6.32 git), it randomly p=
roduces the=A0following errors:=A0

1) Hangs midway through the "Uncompressing Linux ...." stage, and this=A0=
is arbitrary and random on different attempts=A0
2) If it ever does go through, it sometimes displays "invalid=A0compres=
sed format (err =3D 2)" or "crc error", "incomplete literal tree" and s=
ays "System halted"=A0
3) If i disable caching in the kernel (in arch/arm/boot/compressed.S,=A0=
line 233 "bl cache_on"), it at least completes the Uncompressing stage=A0=
fine and proceeds to print "....... done, booting the kernel.", at=A0wh=
ich point it does not boot (most likely since i disabled the=A0caching)=
=A0
4) If i reset the board (not power-cycle) after the board hang above,=A0=
and do a crc32 check on the kernel image in DDR memory (this is=A0
possible since DDR2 memory contents do not get changed after a soft-=A0=
reset), it matches the CRC32 that i have calculated manually on the=A0
kernel image. This shows that the main kernel image (from which it is u=
ncompressed) is still intact.=A0

I've run my own DDR2 tester using the ROM bootloader, and done address/=
bus stuck-at testing as well as complete psuedo-random data testing on=A0=
the full 256MByte memory. They all check out fine. The only difference=A0=
i have from the BeagleBoard is that i'm using the CUS 0.65mm packaged=A0=
version of the OMAP3503 as well as a non-POP LPDDR memory with single=A0=
die (not dual die in the Beagle Board) - hence, i had to modify the=A0D=
DR MCFG register for 14-bit RAS width and 256MByte CS space to get=A0th=
is to work properly.=A0
I've also verified (using CRC checks) that the page tables are intact a=
nd correct before/after the errors happen (full 0x4000 sized page table=
)

If you guys have any ideas, please do help as i'm at my wits end!=A0

Thank you kindly,=A0
Jerry=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
