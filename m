From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP2/3 CM module functions : timeout errors
Date: Sat, 19 Sep 2009 06:23:11 +0300 (EEST)
Message-ID: <1253330591536.juha_motorsportcom.406.U-G9B4S2ViUbUSTZYl5T8g@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from posti.luukku.com ([193.209.83.72]:39253 "EHLO posti.luukku.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbZISDot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 23:44:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org

Hi,

checking some patches thru www.kernel.org
I noticed in

/arch/arm/mach-omap2/cm.c

in function

int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_sh=
ift)
=2E..
       while (((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) !=3D e=
na) &&
              (i++ < MAX_MODULE_READY_TIME))
               udelay(1);

       return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
=2E..
assume MAX_MODULE_READY_TIME=3D=3D1, if first read&check not good,
we enter inside loop and delay.
If second read&check is good, we exit loop, i=3D=3D1.
We return -EBUSY   Wrong!!
If second read&check is not good, we check i and exit loop, i=3D=3D2. W=
e return -EBUSY   OK!!

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
