From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP4 CM module functions : timeout error
Date: Sat, 19 Sep 2009 06:45:18 +0300 (EEST)
Message-ID: <1253331918445.juha_motorsportcom.543.KxHNnTzzfLePULSw2qHuQg@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pato.luukku.com ([194.215.205.55]:38382 "EHLO pato.luukku.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbZISEHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 00:07:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org

Hi,

checking some patches thru www.kernel.org
I noticed in

/arch/arm/mach-omap2/cm4xxx.c

in function

int omap4_cm_wait_idlest_ready(u32 prcm_mod, u8 prcm_dev_offs)
=2E..
       while (((omap4_cm_read_mod_reg(cm_id, prcm_mod_offs, prcm_dev_of=
fs,
                                      OMAP4_CM_CLKCTRL_DREG) & mask) !=3D=
 0) &&
              (i++ < MAX_MODULE_READY_TIME))
               udelay(1);

       return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
=2E..

lets assume MAX_MODULE_READY_TIME=3D=3D1, so it is easier to
see what happens if we exit the loop on the last possible
good read or because i has grown too big(=3D=3Dtimeout).

=46irst read&check is not good, i=3D=3D0, so we delay. i=3D=3D1.
If second and last read&check is good, we exit loop, i=3D=3D1, so we re=
turn -EBUSY.   WRONG!!
If second and last read&check is not good, we then check i, i is too bi=
g so exit loop, i=3D=3D2, so we return -EBUSY.   OK!!
So if exit while loop because i gets too big,
we have MAX_MODULE_READY_TIME udelay(1) and i has grown
to MAX_MODULE_READY_TIME+1.

Simple correction could be something like

-      return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+      return (i > MAX_MODULE_READY_TIME) ? -EBUSY : 0;

Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>

No reply needed to me,
my spam filter will probably eat your reply.

Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
tag would be nice in kernel.org :)
Not so many kernel hackers give credit these days :(

Happy hacking,

Mr. Juha Leppanen
Kuopio, Finland


=2E...................................................................
Luukku Plus -paketilla p=E4=E4set eroon tila- ja turvallisuusongelmista=
=2E
Hanki Luukku Plus ja helpotat el=E4m=E4=E4si. http://www.mtv3.fi/luukku
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
