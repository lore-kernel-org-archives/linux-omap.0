From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: usage of sparse or other trick for improved type safety
Date: Thu, 14 Jun 2012 10:05:17 +0200
Message-ID: <CAORVsuX=UvGELkRaMWPGBUYTW6TRDgg3c=Ghcd3PyvhvVzyzSg@mail.gmail.com>
References: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
	<20120525075328.GM17852@atomide.com>
	<EF62F09C0797D947AD4180A1043C0DF73C43B977@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37834 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754392Ab2FNIFT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 04:05:19 -0400
Received: by lahd3 with SMTP id d3so1043980lah.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 01:05:17 -0700 (PDT)
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73C43B977@DLEE10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>

Hi Richard, all,

On Tue, Jun 12, 2012 at 6:34 PM, Woodruff, Richard <r-woodruff2@ti.com>=
 wrote:
> Hi Tony,
>
>> From: Tony Lindgren [mailto:tony@atomide.com]
>> Sent: Friday, May 25, 2012 2:53 AM
>
> Thanks for quick input. =A0Apologies on slow ack of it.
>
>> Before we had these frameworks in place it was often hard to debug w=
hen
>> something
>> did not work for some omaps. Things would just not work or would sto=
p
>> working
>> for some drivers with no ideas what was going on. So yeah, having th=
ese
>> kind of
>> frameworks in place has helped a lot to avoid breakage like you're
>> describing
>> above.
>
> Trees which had to hit the lowest power states for full customer boar=
ds all employed some form of abstraction of clock, power, voltage. The =
one today in mainline today is the most clean. Aspects around auto-gene=
ration are very good even if a bit big in size.
>
> Perhaps main grump I hear is the number of abstraction layers sometim=
es makes debugging difficult. It would be nice to find smart tricks for=
 compile to prune away some.
>
> Still one can experience some of the mystery issues, as the PRCM conn=
ection to IP-device utilizes a protocol which the device side can mess =
up. If the device does not shut down its local function and associated =
clocks cleanly it will show 'stuck in transition' and this gates final =
global changes. In one of the closed implementation we would bug() driv=
ers who did not shut down their internal clocks properly before allowin=
g global clock release. =A0Most of the issues seen in field are at driv=
ers/peripheral-ip.
>
>
>> For some external subsystems it might be possible to let the omap ke=
rnel
>> manage
>> powerdomains and other resource via remote proc interface, assuming =
these
>> registers are ioremapped in the omap kernel side and not owned by th=
e
>> external
>> subsystem. The messaging to do this would add some undesired latenci=
es
>> though,
>> but maybe those would not be so critical for the external subsystems=
 as
>> they
>> tend to be full on or completely off type accelerators.
>
> Humm. Maybe for some. Guess walking what is used and sorting might te=
ll.
>
> The way some subsystems 'ideal' operation is described from designers=
 implies tight control of timing and sequence for things like power sta=
te. A RPC doesn't feel like it fits with intent. However... practically=
 speaking from 'full system view' RPC may fit sometimes. A subsystem ex=
porting hooks to save 100uW using its optimal state set against other c=
omponents running in 500mW range minimizes usefulness.
>
>> The other alternative of course is to implement similar frameworks f=
or the
>> external subsystems. Some of this might be possible to implement as =
simple
>> macros with some type checks if it's subsystem specific. For doing i=
t for
>> all omap devices, macros were soon found not to be enough as the var=
ious
>> bits all over need to be linked together for managing various resour=
ces.
>
> Agree.
>
> I don't know insides of all subsystems. =A0Though what I know or hear=
 is kind of a mixed picture.
>
> OMAP has an ultra high level of integration. As such you might find s=
omething like DSP-Bios may provide a good hook but quick integration of=
 a previously standalone single purpose piece does not have time to be =
readapted.
>
> The type checking question kind of grows out of this. =A0Linux might =
today offer a clean run-time api which is place where high wall should =
be built with type check. =A0But... the driver might not be able to fun=
ction yet with the API alone given state of evolution of both ends.

Regarding the API and type checking I think the following must be enfor=
ced:
1. proper type checking in the API, possibly by the compiler,
2. clean separation of an API into an internal part (used only by the
framework implementation) and an external part (used by the callers of
the API).

About 1: using enum for the parameters did not help much AFACIT. The
compiler cannot tell if the parameter from a variable is in the
allowed range.
Any thought?

About 2: while introducing the functional power states I came across
this problem. Ideally the current states macros (PWRDM_POWER_* and
PWRSTS_*) shall be used by the internal code only in powerdomain*.[ch]
while the callers (pm.c etc) shall use the new macros
(PWRDM_FUNC_PWRST_*) and API (mainly pwrdm_*_func_* and
omap_set_pwrdm_state).

Here below is a patch extract (trimmed for brevity) to illustrate the p=
roblem.

=46rom here is see a few possible options:
1. clearly separate the internal and external parts of the API in the
header file using comments (as done in the patch below) or with a new
#ifdef POWERDOMAIN_INTERNAL_API (ugly I know),
2. create a new internal only header file (powerdomain_internal.h) and
include it only from powerdomain*.[ch],
3. move the external API to pm.h and keep the internal API in powerdoma=
in.h

Although I am using the func power states as an example I think this
is a applicable to all PM frameworks APIs.

What do you think?


diff --git a/arch/arm/mach-omap2/powerdomain.h
b/arch/arm/mach-omap2/powerdomain.h
index bab84fc..0404f9f 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -26,7 +23,51 @@
-/* Powerdomain basic power states */
+/***************************************************************
+ * External API
+ ***************************************************************/
+
+/* Powerdomain functional power states, used by the external API funct=
ions */
+enum pwrdm_func_state {
+	PWRDM_FUNC_PWRST_OFF		=3D 0x0,
+	PWRDM_FUNC_PWRST_OSWR,
+	PWRDM_FUNC_PWRST_CSWR,
+	PWRDM_FUNC_PWRST_INACTIVE,
+	PWRDM_FUNC_PWRST_ON,
+	PWRDM_MAX_FUNC_PWRSTS		/* Last value, used as the max value */
+};
+
+struct clockdomain;
+struct powerdomain;
+
=2E..
+
+int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm,
+				enum pwrdm_func_state func_pwrst);
+
+
+/***************************************************************
+ * Internal code, only used in powerdomain*.[ch]
+ ***************************************************************/
+
+/* Powerdomain internal power states, internal use only */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
 #define PWRDM_POWER_INACTIVE	0x2
@@ -45,7 +86,6 @@
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)

-
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore suppo=
rt */
 #define PWRDM_HAS_MPU_QUIRK	(1 << 1) /* MPU pwr domain has MEM bank 0 =
bits


> Review question was pointing re-hitting of bugs for what could be arg=
ued 'ideal' internal framework api. How to fix up what is in use by rea=
l drivers or to add/fix external api so its useful should be roadmap.
>
> Regards,
> Richard W.
>

Thanks for starting the discussion!

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
