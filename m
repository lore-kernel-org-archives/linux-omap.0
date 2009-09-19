From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP: omap_hwmod: reset timeout logic
Date: Sat, 19 Sep 2009 07:33:51 +0300 (EEST)
Message-ID: <1253334831932.juha_motorsportcom.975.0YVkO9dYA32q_KrO0U-05g@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from posti.luukku.com ([193.209.83.72]:53983 "EHLO posti.luukku.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbZISEdt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 00:33:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

checking some patches thru www.kernel.org
I noticed something iffy in

/arch/arm/mach-omap2/omap_hwmod.c

in function

static int _reset(struct omap_hwmod *oh)
=2E..
       c =3D 0;
       while (c < MAX_MODULE_RESET_WAIT &&
              !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
                SYSS_RESETDONE_MASK)) {
               udelay(1);
               c++;
       }

       if (c =3D=3D MAX_MODULE_RESET_WAIT)
               WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
                    oh->name, MAX_MODULE_RESET_WAIT);
       else
               pr_debug("omap_hwmod: %s: reset in %d usec\n", oh->name,=
 c);

       /*
        * XXX add _HWMOD_STATE_WEDGED for modules that don't come back =
from
        * _wait_target_ready() or _reset()
        */

       return (c =3D=3D MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
=2E..

Let's assume MAX_MODULE_RESET_WAIT=3D=3D1,
and let's look what happens with the "reset" while loop,
in case where we exit the loop at the last possible
moment.
c=3D=3D0, and rest not done so udelay(1), c=3D1.
We do not loop another time because c=3D=3DMAX_MODULE_RESET_WAIT.
So we give a warning and return -ETIMEDOUT.
Hmmm, we did not check if reset was done while udelay?
Still we warn that "failed to reset in 1 usec"!

Simple correction could be something like
=2E....
       c =3D 0;
-      while (c < MAX_MODULE_RESET_WAIT &&
-             !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
-               SYSS_RESETDONE_MASK)) {
-              udelay(1);
-              c++;
-      }
+      while (!(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
+               SYSS_RESETDONE_MASK) &&
+               (c++ < MAX_MODULE_RESET_WAIT))
+                      udelay(1);

-      if (c =3D=3D MAX_MODULE_RESET_WAIT)
+      if (c > MAX_MODULE_RESET_WAIT)
               WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
<SNIP>
-      return (c =3D=3D MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
+      return (c > MAX_MODULE_RESET_WAIT) ? -ETIMEDOUT : 0;
=2E....

Now we do max MAX_MODULE_RESET_WAIT udelay(1)'s and
always check after udelay(1) if resetdone.

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
