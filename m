From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP2/3 clock: timing logic error in prcm.c
Date: Sat, 19 Sep 2009 08:07:41 +0300 (EEST)
Message-ID: <1253336861024.juha_motorsportcom.1573.6LCQ1zZQT2MHIsa0_PJFxw@luukku.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_545_858059860.1253336861023"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from posti.luukku.com ([193.209.83.72]:43733 "EHLO posti.luukku.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbZISFHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Sep 2009 01:07:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony.lindgren@nokia.com, linux-omap@vger.kernel.org

------=_Part_545_858059860.1253336861023
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

checking some patches thru www.kernel.org
I noticed "off by one" timing logic error in

/arch/arm/mach-omap2/prcm.c

in function

int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
...
        /* Wait for lock */
        while (((__raw_readl(reg) & mask) !=3D ena) &&
               (i++ < MAX_MODULE_ENABLE_WAIT))
                udelay(1);

        if (i < MAX_MODULE_ENABLE_WAIT)
                pr_debug("cm: Module associated with clock %s ready after %=
d "
                         "loops\n", name, i);
        else
                pr_err("cm: Module associated with clock %s didn't enable i=
n "
                       "%d tries\n", name, MAX_MODULE_ENABLE_WAIT);

        return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
...
If the while loop "timeouts", i=3D=3DMAX_MODULE_ENABLE_WAIT+1.

Simple correction could be something like

....
-       if (i < MAX_MODULE_ENABLE_WAIT)
+       if (i <=3D MAX_MODULE_ENABLE_WAIT)
                pr_debug("cm: Module associated with clock %s ready after %=
d "
<SNIP>
-       return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
+       return (i <=3D MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
....

Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>

No reply needed to me,
my spam filter will probably eat your reply.

Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
tag would be nice in kernel.org :)
Not so many kernel hackers give credit these days :(

Happy hacking,

Mr. Juha Leppanen
Kuopio, Finland


....................................................................
Luukku Plus -paketilla p=E4=E4set eroon tila- ja turvallisuusongelmista.
Hanki Luukku Plus ja helpotat el=E4m=E4=E4si. http://www.mtv3.fi/luukku

------=_Part_545_858059860.1253336861023--
