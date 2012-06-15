From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: usage of sparse or other trick for improved type safety
Date: Fri, 15 Jun 2012 13:12:15 +0200
Message-ID: <CAORVsuWTYVuqDU_Jb0+8bD3RD4wt_sj_r6yEGMVhzG-qwOXgFw@mail.gmail.com>
References: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
	<20120525075328.GM17852@atomide.com>
	<EF62F09C0797D947AD4180A1043C0DF73C43B977@DLEE10.ent.ti.com>
	<CAORVsuX=UvGELkRaMWPGBUYTW6TRDgg3c=Ghcd3PyvhvVzyzSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62380 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753469Ab2FOLMS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 07:12:18 -0400
Received: by lahd3 with SMTP id d3so1976391lah.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 04:12:16 -0700 (PDT)
In-Reply-To: <CAORVsuX=UvGELkRaMWPGBUYTW6TRDgg3c=Ghcd3PyvhvVzyzSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi!

Added Paul in Cc:.

On Thu, Jun 14, 2012 at 10:05 AM, Jean Pihet <jean.pihet@newoldbits.com=
> wrote:
> Hi Richard, all,
>
> On Tue, Jun 12, 2012 at 6:34 PM, Woodruff, Richard <r-woodruff2@ti.co=
m> wrote:
>> Hi Tony,
>>
>>> From: Tony Lindgren [mailto:tony@atomide.com]
>>> Sent: Friday, May 25, 2012 2:53 AM
>>
>> Thanks for quick input. =A0Apologies on slow ack of it.
>>
>>> Before we had these frameworks in place it was often hard to debug =
when
>>> something
>>> did not work for some omaps. Things would just not work or would st=
op
>>> working
>>> for some drivers with no ideas what was going on. So yeah, having t=
hese
>>> kind of
>>> frameworks in place has helped a lot to avoid breakage like you're
>>> describing
>>> above.
>>
>> Trees which had to hit the lowest power states for full customer boa=
rds all employed some form of abstraction of clock, power, voltage. The=
 one today in mainline today is the most clean. Aspects around auto-gen=
eration are very good even if a bit big in size.
>>
>> Perhaps main grump I hear is the number of abstraction layers someti=
mes makes debugging difficult. It would be nice to find smart tricks fo=
r compile to prune away some.
>>
>> Still one can experience some of the mystery issues, as the PRCM con=
nection to IP-device utilizes a protocol which the device side can mess=
 up. If the device does not shut down its local function and associated=
 clocks cleanly it will show 'stuck in transition' and this gates final=
 global changes. In one of the closed implementation we would bug() dri=
vers who did not shut down their internal clocks properly before allowi=
ng global clock release. =A0Most of the issues seen in field are at dri=
vers/peripheral-ip.
>>
>>
>>> For some external subsystems it might be possible to let the omap k=
ernel
>>> manage
>>> powerdomains and other resource via remote proc interface, assuming=
 these
>>> registers are ioremapped in the omap kernel side and not owned by t=
he
>>> external
>>> subsystem. The messaging to do this would add some undesired latenc=
ies
>>> though,
>>> but maybe those would not be so critical for the external subsystem=
s as
>>> they
>>> tend to be full on or completely off type accelerators.
>>
>> Humm. Maybe for some. Guess walking what is used and sorting might t=
ell.
>>
>> The way some subsystems 'ideal' operation is described from designer=
s implies tight control of timing and sequence for things like power st=
ate. A RPC doesn't feel like it fits with intent. However... practicall=
y speaking from 'full system view' RPC may fit sometimes. A subsystem e=
xporting hooks to save 100uW using its optimal state set against other =
components running in 500mW range minimizes usefulness.
>>
>>> The other alternative of course is to implement similar frameworks =
for the
>>> external subsystems. Some of this might be possible to implement as=
 simple
>>> macros with some type checks if it's subsystem specific. For doing =
it for
>>> all omap devices, macros were soon found not to be enough as the va=
rious
>>> bits all over need to be linked together for managing various resou=
rces.
>>
>> Agree.
>>
>> I don't know insides of all subsystems. =A0Though what I know or hea=
r is kind of a mixed picture.
>>
>> OMAP has an ultra high level of integration. As such you might find =
something like DSP-Bios may provide a good hook but quick integration o=
f a previously standalone single purpose piece does not have time to be=
 readapted.
>>
>> The type checking question kind of grows out of this. =A0Linux might=
 today offer a clean run-time api which is place where high wall should=
 be built with type check. =A0But... the driver might not be able to fu=
nction yet with the API alone given state of evolution of both ends.
>
> Regarding the API and type checking I think the following must be enf=
orced:
> 1. proper type checking in the API, possibly by the compiler,
> 2. clean separation of an API into an internal part (used only by the
> framework implementation) and an external part (used by the callers o=
f
> the API).
>
> About 1: using enum for the parameters did not help much AFACIT. The
> compiler cannot tell if the parameter from a variable is in the
> allowed range.
> Any thought?
>
> About 2: while introducing the functional power states I came across
> this problem. Ideally the current states macros (PWRDM_POWER_* and
> PWRSTS_*) shall be used by the internal code only in powerdomain*.[ch=
]
> while the callers (pm.c etc) shall use the new macros
> (PWRDM_FUNC_PWRST_*) and API (mainly pwrdm_*_func_* and
> omap_set_pwrdm_state).
>
> Here below is a patch extract (trimmed for brevity) to illustrate the=
 problem.
=46YI the full patch is at http://marc.info/?l=3Dlinux-omap&m=3D1339685=
81305050&w=3D2

>
> From here is see a few possible options:
> 1. clearly separate the internal and external parts of the API in the
> header file using comments (as done in the patch below) or with a new
> #ifdef POWERDOMAIN_INTERNAL_API (ugly I know),
Some more details about that option: the internal values could be
prefixed by '__' or similar which kinds of highlights a bad API usage.

> 2. create a new internal only header file (powerdomain_internal.h) an=
d
> include it only from powerdomain*.[ch],
> 3. move the external API to pm.h and keep the internal API in powerdo=
main.h
>
> Although I am using the func power states as an example I think this
> is a applicable to all PM frameworks APIs.
>
> What do you think?
Any thought?

> diff --git a/arch/arm/mach-omap2/powerdomain.h
> b/arch/arm/mach-omap2/powerdomain.h
> index bab84fc..0404f9f 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -26,7 +23,51 @@
> -/* Powerdomain basic power states */
> +/***************************************************************
> + * External API
> + ***************************************************************/
> +
> +/* Powerdomain functional power states, used by the external API fun=
ctions */
> +enum pwrdm_func_state {
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_OFF =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_OSWR,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_CSWR,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_INACTIVE,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_ON,
> + =A0 =A0 =A0 PWRDM_MAX_FUNC_PWRSTS =A0 =A0 =A0 =A0 =A0 /* Last value=
, used as the max value */
> +};
> +
> +struct clockdomain;
> +struct powerdomain;
> +
> ...
> +
> +int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
> +int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
> +int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
> +extern int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pw=
rdm_func_state func_pwrst);
> +
> +
> +/***************************************************************
> + * Internal code, only used in powerdomain*.[ch]
> + ***************************************************************/
> +
> +/* Powerdomain internal power states, internal use only */
> =A0#define PWRDM_POWER_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> =A0#define PWRDM_POWER_RET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
> =A0#define PWRDM_POWER_INACTIVE =A0 0x2
> @@ -45,7 +86,6 @@
> =A0#define PWRSTS_RET_ON =A0 =A0 =A0 =A0 =A0(PWRSTS_RET | PWRSTS_ON)
> =A0#define PWRSTS_OFF_RET_ON =A0 =A0 =A0(PWRSTS_OFF_RET | PWRSTS_ON)
>
> -
> =A0/* Powerdomain flags */
> =A0#define PWRDM_HAS_HDWR_SAR =A0 =A0 (1 << 0) /* hardware save-and-r=
estore support */
> =A0#define PWRDM_HAS_MPU_QUIRK =A0 =A0(1 << 1) /* MPU pwr domain has =
MEM bank 0 bits
>
>
>> Review question was pointing re-hitting of bugs for what could be ar=
gued 'ideal' internal framework api. How to fix up what is in use by re=
al drivers or to add/fix external api so its useful should be roadmap.
>>
>> Regards,
>> Richard W.
>>
>
> Thanks for starting the discussion!
>
> Regards,
> Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
