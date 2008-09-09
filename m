From: =?windows-1252?Q?Ram=F3n_Finger_Lilienthal?=
	<ramon@instramed.com.br>
Subject: Error compiling for OMAP 5912
Date: Tue, 09 Sep 2008 15:23:27 -0300
Message-ID: <48C6BF1F.5020203@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sr03-10.mta.terra.com.br ([200.154.152.49]:58716 "EHLO
	sr03-10.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077AbYIISX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:23:29 -0400
Received: from acangera.hst.terra.com.br (acangera.hst.terra.com.br [200.176.10.17])
	by bungunia.hst.terra.com.br (Postfix) with ESMTP id 5258C6607CA
	for <linux-omap@vger.kernel.org>; Tue,  9 Sep 2008 15:23:26 -0300 (BRT)
Received: from [192.168.1.101] (unknown [201.37.105.27])
	(authenticated user ramoninstramed@terra.com.br)
	by acangera.hst.terra.com.br (Postfix) with ESMTP id 3C3123F0102
	for <linux-omap@vger.kernel.org>; Tue,  9 Sep 2008 15:23:25 -0300 (BRT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear friends,

I am trying to compile the kernel for omap5912, and it's not working.
My current kernel version is:
VERSION =3D 2
PATCHLEVEL =3D 6
SUBLEVEL =3D 27
EXTRAVERSION =3D -rc5
NAME =3D Rotary Wombat

I got this error from compiler:
-----------------------------------------------------------------------=
------------------------------------
LD drivers/hwmon/built-in.o
CC drivers/i2c/i2c-boardinfo.o
CC drivers/i2c/i2c-core.o
CC drivers/i2c/i2c-dev.o
LD drivers/i2c/algos/built-in.o
CC drivers/i2c/busses/i2c-omap.o
LD drivers/i2c/busses/built-in.o
CC drivers/i2c/chips/tps65010.o
LD drivers/i2c/chips/built-in.o
CC [M] drivers/i2c/chips/tlv320aic23.o
drivers/i2c/chips/tlv320aic23.c: In function =91omap_mcbsp3_aic23_clock=
_init=92:
drivers/i2c/chips/tlv320aic23.c:113: error: implicit declaration of=20
function =91OMAP_MCBSP_WRITE=92
drivers/i2c/chips/tlv320aic23.c:113: error: =91SPCR1=92 undeclared (fir=
st=20
use in this function)
drivers/i2c/chips/tlv320aic23.c:113: error: (Each undeclared identifier=
=20
is reported only once
drivers/i2c/chips/tlv320aic23.c:113: error: for each function it appear=
s=20
in.)
drivers/i2c/chips/tlv320aic23.c:114: error: =91SPCR2=92 undeclared (fir=
st=20
use in this function)
drivers/i2c/chips/tlv320aic23.c:117: error: =91PCR0=92 undeclared (firs=
t use=20
in this function)
drivers/i2c/chips/tlv320aic23.c:120: error: =91SRGR1=92 undeclared (fir=
st=20
use in this function)
drivers/i2c/chips/tlv320aic23.c:121: error: =91SRGR2=92 undeclared (fir=
st=20
use in this function)
drivers/i2c/chips/tlv320aic23.c:124: error: implicit declaration of=20
function =91OMAP_MCBSP_READ=92
drivers/i2c/chips/tlv320aic23.c: At top level:
drivers/i2c/chips/tlv320aic23.c:287: error: redefinition of=20
=91aic23_power_down=92
arch/arm/plat-omap/include/mach/aic23.h:122: error: previous definition=
=20
of =91aic23_power_down=92 was here
drivers/i2c/chips/tlv320aic23.c:296: error: redefinition of =91aic23_po=
wer_up=92
arch/arm/plat-omap/include/mach/aic23.h:118: error: previous definition=
=20
of =91aic23_power_up=92 was here
make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
make[2]: *** [drivers/i2c/chips] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2
-----------------------------------------------------------------------=
------------------------------------

Any help will be welcome!

--=20
Regards,
Eng. Ramon F. Lilienthal
Project Engineer
Instramed Ltda. - www.instramed.com.br
+55 (51) 33344199 ext. 213

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
