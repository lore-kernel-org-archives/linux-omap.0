From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 6 / 12] Mach omap2 updation for 3430
Date: Fri, 15 Jun 2007 08:40:44 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470810F1@dlee13.ent.ti.com>
References: <20070614114651.GF28804@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47011E659F@dlee13.ent.ti.com>
	<20070615081323.GD10128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> Note: We will not include omap24xx.h for 34xx compilation (vice =
versa).

>We can include them, it should not hurt as the defines have 24XX or
> 34XX prefix.
This was giving compilation issues, when I tried. Have to double check.

> Option 1: Having such Macros with same name in both 24xx and 34xx .h =
files
>
> In omap24xx.h:
> #define OMAP_IC_BASE  <OMAP2 IC BASE VALUE>
>
> In omap34xx.h
> #define OMAP_IC_BASE  < OMAP3 IC BASE VALUE >
>
> Option 2: Having a separate header file for such macros.
>
> omap_common.h
> #define OMAP24XX_IC_BASE      < OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE      < OMAP3 IC BASE VALUE >
>
> This common header file can be included in both 24xx and 34xx board =
files
>
> Option 3: Define both macros in 24xx and 34xx header files (Crap).
>
> In omap24xx.h:
> #define OMAP24XX_IC_BASE      < OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE      < OMAP3 IC BASE VALUE >#define =
OMAP_IC_BASE
>
> In omap34xx.h
> #define OMAP24XX_IC_BASE      < OMAP2 IC BASE VALUE >
> #define OMAP34XX_IC_BASE      < OMAP3 IC BASE VALUE >#define =
OMAP_IC_BASE
>
>
> Kindly let me know your views on the same.

>Well I think option 2 or 3 may still be the best if we eventually want
>to compile both 24xx and 34xx into the same kernel. Maybe just have it
>defined in irq.c or .h if not needed elsewhere?

OK, I will work on one of these option. Can you consider this patch for =
first level merge. I will work on all other comments and submit them by =
next week.
=20
If some thing gets changed on GIT, it will be hard to re-sync / re-post =
all these patches again :)
=20
Regards,
Khasim
=20

=20
