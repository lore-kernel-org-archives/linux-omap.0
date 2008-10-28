From: =?windows-1252?Q?Ram=F3n_Finger_Lilienthal?=
	<ramon@instramed.com.br>
Subject: TLV320AIC23 not patched
Date: Tue, 28 Oct 2008 10:17:16 -0200
Message-ID: <490702CC.9070008@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sr05-08.mta.terra.com.br ([200.154.152.67]:42283 "EHLO
	sr05-08.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYJ1MRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2008 08:17:18 -0400
Received: from tarmula.hst.terra.com.br (tarmula.hst.terra.com.br [200.176.10.4])
	by buraja.hst.terra.com.br (Postfix) with ESMTP id D0A7A4000184
	for <linux-omap@vger.kernel.org>; Tue, 28 Oct 2008 12:17:15 +0000 (UTC)
Received: from [192.168.1.105] (unknown [201.21.243.40])
	(authenticated user ramoninstramed@terra.com.br)
	by tarmula.hst.terra.com.br (Postfix) with ESMTP id C2BE7600000BC
	for <linux-omap@vger.kernel.org>; Tue, 28 Oct 2008 12:17:15 +0000 (UTC)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46ellows,

I have just got the v2.6.28-rc2, and errors while compiling still happe=
ning.

---
CHK include/linux/compile.h
CC drivers/i2c/chips/tlv320aic23.o
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
make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
make[2]: *** [drivers/i2c/chips] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2
---

These errors was solved by some patchs in August. Why these patchs=20
wasn't applied in the kernel tree?


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
