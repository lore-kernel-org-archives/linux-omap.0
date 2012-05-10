From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 05/10] ARM: OMAP2+: SmartReflex: introduce a busy loop
 condition test macro
Date: Thu, 10 May 2012 11:49:47 +0530
Message-ID: <CAJ6a13Z4AuDccR2o0nzQO+tnL59PbAVtFkzYDCd1FU_VuiZOVw@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<1335462041-4949-6-git-send-email-j-keerthy@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1B40@DBDE01.ent.ti.com>
	<CAJ6a13aA9nutZvRkcj8GHok9cEe8A=J2bwzSXt=Sd0Hu_WPaPw@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B667C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:40815 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754290Ab2EJGTs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:19:48 -0400
Received: by obbup16 with SMTP id up16so1317393obb.25
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:19:47 -0700 (PDT)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9B667C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>

On Tue, May 8, 2012 at 3:47 PM, AnilKumar, Chimata <anilkumar@ti.com> w=
rote:
> On Mon, May 07, 2012 at 10:51:53, J, KEERTHY wrote:
>> On Fri, May 4, 2012 at 2:42 PM, AnilKumar, Chimata <anilkumar@ti.com=
> wrote:
>> > On Thu, Apr 26, 2012 at 23:10:36, J, KEERTHY wrote:
>> >> From: Jean Pihet <j-pihet@ti.com>
>> >>
>> >> Now that omap_test_timeout is only accessible from mach-omap2/,
>> >> introduce a similar function for SR.
>> >>
>> >> This change makes the SmartReflex implementation ready for the mo=
ve
>> >> to drivers/.
>> >>
>> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> >> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>> >> ---
>> >> =A0arch/arm/mach-omap2/smartreflex.c | =A0 12 ++++++------
>> >> =A0include/linux/power/smartreflex.h | =A0 23 +++++++++++++++++++=
+++-
>> >> =A02 files changed, 28 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-om=
ap2/smartreflex.c
>> >> index d859277..acef08d 100644
>> >> --- a/arch/arm/mach-omap2/smartreflex.c
>> >> +++ b/arch/arm/mach-omap2/smartreflex.c
>> >> @@ -289,9 +289,9 @@ static void sr_v1_disable(struct omap_sr *sr)
>> >> =A0 =A0 =A0 =A0* Wait for SR to be disabled.
>> >> =A0 =A0 =A0 =A0* wait until ERRCONFIG.MCUDISACKINTST =3D 1. Typic=
al latency is 1us.
>> >> =A0 =A0 =A0 =A0*/
>> >> - =A0 =A0 omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ERRCONFIG_MCUDISACKINTS=
T), SR_DISABLE_TIMEOUT,
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout);
>> >> + =A0 =A0 sr_test_cond_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ERRCONFIG_MC=
UDISACKINTST), SR_DISABLE_TIMEOUT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
>> >>
>> >> =A0 =A0 =A0 if (timeout >=3D SR_DISABLE_TIMEOUT)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: Smartre=
flex disable timedout\n",
>> >> @@ -334,9 +334,9 @@ static void sr_v2_disable(struct omap_sr *sr)
>> >> =A0 =A0 =A0 =A0* Wait for SR to be disabled.
>> >> =A0 =A0 =A0 =A0* wait until IRQSTATUS.MCUDISACKINTST =3D 1. Typic=
al latency is 1us.
>> >> =A0 =A0 =A0 =A0*/
>> >> - =A0 =A0 omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQSTATUS_MCUDISABLEACK=
INT), SR_DISABLE_TIMEOUT,
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout);
>> >> + =A0 =A0 sr_test_cond_timeout((sr_read_reg(sr, IRQSTATUS) &
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQSTATUS_MC=
UDISABLEACKINT), SR_DISABLE_TIMEOUT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
>> >>
>> >> =A0 =A0 =A0 if (timeout >=3D SR_DISABLE_TIMEOUT)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&sr->pdev->dev, "%s: Smartre=
flex disable timedout\n",
>> >> diff --git a/include/linux/power/smartreflex.h b/include/linux/po=
wer/smartreflex.h
>> >> index 884eaee..78b795e 100644
>> >> --- a/include/linux/power/smartreflex.h
>> >> +++ b/include/linux/power/smartreflex.h
>> >> @@ -22,7 +22,7 @@
>> >>
>> >> =A0#include <linux/types.h>
>> >> =A0#include <linux/platform_device.h>
>> >> -
>> >> +#include <linux/delay.h>
>> >> =A0#include <plat/voltage.h>
>> >>
>> >> =A0/*
>> >> @@ -168,6 +168,27 @@ struct omap_sr {
>> >> =A0};
>> >>
>> >> =A0/**
>> >> + * test_cond_timeout - busy-loop, testing a condition
>> >> + * @cond: condition to test until it evaluates to true
>> >> + * @timeout: maximum number of microseconds in the timeout
>> >> + * @index: loop index (integer)
>> >> + *
>> >> + * Loop waiting for @cond to become true or until at least @time=
out
>> >> + * microseconds have passed. =A0To use, define some integer @ind=
ex in the
>> >> + * calling code. =A0After running, if @index =3D=3D @timeout, th=
en the loop has
>> >> + * timed out.
>> >> + *
>> >> + * Copied from omap_test_timeout */
>> >> +#define sr_test_cond_timeout(cond, timeout, index) =A0 =A0 =A0 =A0=
 =A0 \
>> >> +({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> >> + =A0 =A0 for (index =3D 0; index < timeout; index++) { =A0 =A0 =A0=
 =A0 =A0 =A0 \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (cond) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break; =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> >> + =A0 =A0 } =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> >> +})
>> >
>> > I think we can use time_after()/time_before() APIs for timeout and=
 cpu_relax() for
>> > tight loops instead of udelay().
>>
>> cpu_relax() changes the priority everytime to low and will yield to
>> another thread.
>> Considering that we are checking the condition every microsecond doe=
s it make
>> some saving using cpu_relax().
>>
>
> cpu_relax() does not involve any priority changes or scheduling AFAIC=
S.
> Have a look at this thread:
>
> http://www.spinics.net/lists/netdev/msg151699.html

Thanks. My bad. I meant yielding to another thread with in a space
of 1uS.

>
> Regards
> AnilKumar
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
