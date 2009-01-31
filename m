From: Belisko Marek <marek.belisko@gmail.com>
Subject: TI omap850
Date: Sat, 31 Jan 2009 20:38:12 +0100
Message-ID: <e7c6a05e0901311138t8e37768ya8e47f5fb8f2d728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:8016 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbZAaTiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 14:38:14 -0500
Received: by fg-out-1718.google.com with SMTP id 16so276564fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2009 11:38:12 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to port Linux on HTC Oxygen (omap850). As start point I choo=
se
previous port at:http://vivien.chappelier.free.fr/typhoon/index.html

I try to modify tft driver for my board but with no success. I'm still
missing some
variables in  lcd_panel structure.

What important is still missing is pixel_freq parameter.
I have an egg and chicken problem. Rootfs as initrd is not working
(don't know why)
and display also not :). So I try to focus on display.

I dump some memory regions with Haret to get clock detailed infos.
Dumps:
ARM_CKCTL=3D0x6506 is different from the settings in
the linux kernel for CONFIG_OMAP_ARM_195MHZ (0x050e).

DPLL_CTL=3D0x2fb3 is different from the settings in
the linux kernel for CONFIG_OMAP_ARM_195MHZ (0x2790).

=46or retreiving of pixel_freq I can use
function in lcdc.c lck =3D clk_get_rate(omap_lcdc.lcd_ck); but
I'ts hard for me to find how clock on OMAP is working (very complex
for beginner).

Could you please clarify this to me and also why values ARM_CKCTL
and DPLL_CTL are in kernel set differently (compare to wince).


thanks,


Marek

--=20
as simple as primitive as possible
----------------------------------------------
Marek Beli=C5=A1ko - open-nandra
Rusk=C3=A1 Nov=C3=A1 Ves 219
08005 Pre=C5=A1ov
Slovakia
http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
