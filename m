From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling
 mechanism within UART driver
Date: Mon, 1 Aug 2011 15:26:52 +0530
Message-ID: <CAMrsUdL_9mzKsjrKf=spihxcRTQc6Tsr+MAP9GFAz_7sE27B6Q@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
	<20110729095512.GE31013@legolas.emea.dhcp.ti.com>
	<CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
	<20110729113713.GK31013@legolas.emea.dhcp.ti.com>
	<CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
	<20110729121907.GM31013@legolas.emea.dhcp.ti.com>
	<CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
	<20110729140210.GT31013@legolas.emea.dhcp.ti.com>
	<CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
	<20110801090328.GG31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7872865836262816405=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110801090328.GG31013@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: balbi@ti.com
Cc: Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-serial@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============7872865836262816405==
Content-Type: multipart/alternative; boundary=20cf3010edafb65b8c04a96ea735

--20cf3010edafb65b8c04a96ea735
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 1, 2011 at 2:33 PM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Fri, Jul 29, 2011 at 08:43:49PM +0530, Govindraj wrote:
>
> [giant snip]
>
> > Actually there is much more than this:
> >
> > <<SNIP>>
> >
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index 180299e..221ffb9 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -12,7 +12,8 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > -#undef DEBUG
> > +//#undef DEBUG
> > +#define DEBUG
>
> trailing... but you know that :-p
>

yes true.


> > @@ -254,14 +255,14 @@ void omap2_clk_disable(struct clk *clk)
> >               return;
> >       }
> >
> > -     pr_debug("clock: %s: decrementing usecount\n", clk->name);
> > +//   pr_debug("clock: %s: decrementing usecount\n", clk->name);
> >
> >       clk->usecount--;
> >
> >       if (clk->usecount > 0)
> >               return;
> >
> > -     pr_debug("clock: %s: disabling in hardware\n", clk->name);
> > +//   pr_debug("clock: %s: disabling in hardware\n", clk->name);
> >
> >       if (clk->ops && clk->ops->disable) {
> >               trace_clock_disable(clk->name, 0, smp_processor_id());
>
> this hunk is unnecessary. Clocks are always on when they are called.
>

The problem is:

[1]:

runtime_put -> *power.lock* - > rpm->suspend -> above pr_debug ->
console_write -> get_sync

-> *power.lock* -> rpm resume

power.lock contention.



>
> > @@ -290,14 +291,14 @@ int omap2_clk_enable(struct clk *clk)
> >  {
> >       int ret;
> >
> > -     pr_debug("clock: %s: incrementing usecount\n", clk->name);
> > +//   pr_debug("clock: %s: incrementing usecount\n", clk->name);
> >
> >       clk->usecount++;
> >
> >       if (clk->usecount > 1)
> >               return 0;
> >
> > -     pr_debug("clock: %s: enabling in hardware\n", clk->name);
> > +//   pr_debug("clock: %s: enabling in hardware\n", clk->name);
>
> these two is ok.
>
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> b/arch/arm/mach-omap2/omap_hwmod.c
> > index 7ed0479..8ca7d40 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -124,7 +124,8 @@
> >   * XXX error return values should be checked to ensure that they are
> >   * appropriate
> >   */
> > -#undef DEBUG
> > +//#undef DEBUG
> > +#define DEBUG
>
> trailing.
>
> > @@ -597,7 +598,8 @@ static int _enable_clocks(struct omap_hwmod *oh)
> >  {
> >       int i;
> >
> > -     pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
> > +     if (strcmp(oh->class->name, "uart"))
> > +             pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
>
> instead of doing checks, you could move the print to the end of the
> function, when clocks are already enabled. When doind that, of course,
> update the comment to say "%s: clocks enabled\n".
>


the problem is the prints causing power.lock contention same as
the scenario in [1] above.



>
> > @@ -627,7 +629,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
> >  {
> >       int i;
> >
> > -     pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
> > +     if (strcmp(oh->class->name, "uart"))
> > +             pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
>
> check not needed, clocks are still on.
>

scenario [1]



>
> >
> >       if (oh->_clk)
> >               clk_disable(oh->_clk);
> > @@ -1232,7 +1235,8 @@ static int _enable(struct omap_hwmod *oh)
> >               return -EINVAL;
> >       }
> >
> > -     pr_debug("omap_hwmod: %s: enabling\n", oh->name);
> > +     if (strcmp(oh->class->name, "uart"))
> > +             pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>
> move it further down.
>
> > @@ -1264,8 +1268,9 @@ static int _enable(struct omap_hwmod *oh)
> >               }
> >       } else {
> >               _disable_clocks(oh);
> > -             pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
> > -                      oh->name, r);
> > +             if (strcmp(oh->class->name, "uart"))
> > +                     pr_debug("omap_hwmod: %s: _wait_target_ready:
> %d\n",
> > +                              oh->name, r);
>
> instead of adding check, move the print before _disable_clocks(oh).
>
> > @@ -1287,7 +1292,8 @@ static int _idle(struct omap_hwmod *oh)
> >               return -EINVAL;
> >       }
> >
> > -     pr_debug("omap_hwmod: %s: idling\n", oh->name);
> > +     if (strcmp(oh->class->name, "uart"))
> > +             pr_debug("omap_hwmod: %s: idling\n", oh->name);
>
> I believe clocks are still on here too, no checks needed.
>
> > diff --git a/arch/arm/plat-omap/omap_device.c
> b/arch/arm/plat-omap/omap_device.c
> > index 49fc0df..7b27704 100644
> > --- a/arch/arm/plat-omap/omap_device.c
> > +++ b/arch/arm/plat-omap/omap_device.c
> > @@ -75,7 +75,8 @@
> >   * (device must be reinitialized at this point to use it again)
> >   *
> >   */
> > -#undef DEBUG
> > +//#undef DEBUG
> > +#define DEBUG
>
> trailing.
>
> > @@ -114,7 +115,8 @@ static int _omap_device_activate(struct
> > omap_device *od, u8 ignore_lat)
> >  {
> >       struct timespec a, b, c;
> >
> > -     pr_debug("omap_device: %s: activating\n", od->pdev.name);
> > +     if (strcmp(od->hwmods[0]->class->name, "uart"))
> > +             pr_debug("omap_device: %s: activating\n", od->pdev.name);
>
> move it to the end of the function.
>
> > @@ -138,25 +140,29 @@ static int _omap_device_activate(struct
> > omap_device *od, u8 ignore_lat)
> >               c = timespec_sub(b, a);
> >               act_lat = timespec_to_ns(&c);
> >
> > -             pr_debug("omap_device: %s: pm_lat %d: activate: elapsed
> time "
> > -                      "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> > -                      act_lat);
> > +             if (strcmp(od->hwmods[0]->class->name, "uart"))
> > +                     pr_debug("omap_device: %s: pm_lat %d: activate:
> elapsed time "
> > +                              "%llu nsec\n", od->pdev.name,
> od->pm_lat_level,
> > +                              act_lat);
>
> move it further down.
>
> >
> >               if (act_lat > odpl->activate_lat) {
> >                       odpl->activate_lat_worst = act_lat;
> >                       if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST)
> {
> >                               odpl->activate_lat = act_lat;
> > -                             pr_warning("omap_device: %s.%d: new worst
> case "
> > -                                        "activate latency %d: %llu\n",
> > -                                        od->pdev.name, od->pdev.id,
> > -                                        od->pm_lat_level, act_lat);
> > -                     } else
> > -                             pr_warning("omap_device: %s.%d: activate "
> > -                                        "latency %d higher than
> exptected. "
> > -                                        "(%llu > %d)\n",
> > -                                        od->pdev.name, od->pdev.id,
> > -                                        od->pm_lat_level, act_lat,
> > -                                        odpl->activate_lat);
> > +                             if (strcmp(od->hwmods[0]->class->name,
> "uart"))
> > +                                     pr_warning("omap_device: %s.%d: new
> worst case "
> > +                                             "activate latency %d:
> %llu\n",
> > +                                             od->pdev.name, od->pdev.id
> ,
> > +                                             od->pm_lat_level, act_lat);
> > +                     } else {
> > +                             if (strcmp(od->hwmods[0]->class->name,
> "uart"))
> > +                                     pr_warning("omap_device: %s.%d:
> activate "
> > +                                             "latency %d higher than
> exptected. "
> > +                                             "(%llu > %d)\n",
> > +                                             od->pdev.name, od->pdev.id
> ,
> > +                                             od->pm_lat_level, act_lat,
> > +                                             odpl->activate_lat);
>
> ->activate_func() has already been called here, clocks are already on.
>
> > @@ -183,7 +189,8 @@ static int _omap_device_deactivate(struct
> > omap_device *od, u8 ignore_lat)
> >  {
> >       struct timespec a, b, c;
> >
> > -     pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
> > +     if (strcmp(od->hwmods[0]->class->name, "uart"))
> > +             pr_debug("omap_device: %s: deactivating\n", od->pdev.name
> );
>
> clocks are still on here.
>
> > @@ -206,25 +213,29 @@ static int _omap_device_deactivate(struct
> > omap_device *od, u8 ignore_lat)
> >               c = timespec_sub(b, a);
> >               deact_lat = timespec_to_ns(&c);
> >
> > -             pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed
> time "
> > -                      "%llu nsec\n", od->pdev.name, od->pm_lat_level,
> > -                      deact_lat);
> > +             if (strcmp(od->hwmods[0]->class->name, "uart"))
> > +                     pr_debug("omap_device: %s: pm_lat %d: deactivate:
> elapsed time "
> > +                              "%llu nsec\n", od->pdev.name,
> od->pm_lat_level,
> > +                              deact_lat);
>
> I'll leave this to Kevin to decide what to do, but clocks are off
> here...
>

Yes fine.

Since most of these prints will be printed if DEBUG macro
is defined in respective files and *debug* is used in command line.

Can't leave uart clocks active always on debug cases.
[If *debug*  used as command line]
and gate uart clocks only for non debug cases.

With this approach at least we can have a clean solution
in uart driver also without adding clock gating from idle path.

Not sure if this agreeable.

As of now gating from idle path seems to be only clean approach.

-- 
Thanks,
Govindraj.R



> >               if (deact_lat > odpl->deactivate_lat) {
> >                       odpl->deactivate_lat_worst = deact_lat;
> >                       if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST)
> {
> >                               odpl->deactivate_lat = deact_lat;
> > -                             pr_warning("omap_device: %s.%d: new worst
> case "
> > -                                        "deactivate latency %d: %llu\n",
> > -                                        od->pdev.name, od->pdev.id,
> > -                                        od->pm_lat_level, deact_lat);
> > -                     } else
> > -                             pr_warning("omap_device: %s.%d: deactivate
> "
> > +                             if (strcmp(od->hwmods[0]->class->name,
> "uart"))
> > +                                     pr_warning("omap_device: %s.%d: new
> worst case "
> > +                                                "deactivate latency %d:
> %llu\n",
> > +                                                od->pdev.name, od->
> pdev.id,
> > +                                                od->pm_lat_level,
> deact_lat);
> > +                     } else {
> > +                             if (strcmp(od->hwmods[0]->class->name,
> "uart"))
> > +                                     pr_warning("omap_device: %s.%d:
> deactivate "
> >                                          "latency %d higher than
> exptected. "
> >                                          "(%llu > %d)\n",
> >                                          od->pdev.name, od->pdev.id,
> >                                          od->pm_lat_level, deact_lat,
> >                                          odpl->deactivate_lat);
> > +                     }
>
> and here...
>
> --
> balbi
>

--20cf3010edafb65b8c04a96ea735
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Mon, Aug 1, 2011 at 2:33 PM, Felipe Balbi=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:balbi@ti.com">balbi@ti.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex;">

Hi,<br>
<br>
On Fri, Jul 29, 2011 at 08:43:49PM +0530, Govindraj wrote:<br>
<br>
[giant snip]<br>
<div class=3D"im"><br>
&gt; Actually there is much more than this:<br>
&gt;<br>
&gt; &lt;&lt;SNIP&gt;&gt;<br>
&gt;<br>
&gt; diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c=
<br>
&gt; index 180299e..221ffb9 100644<br>
&gt; --- a/arch/arm/mach-omap2/clock.c<br>
&gt; +++ b/arch/arm/mach-omap2/clock.c<br>
&gt; @@ -12,7 +12,8 @@<br>
&gt; =A0 * it under the terms of the GNU General Public License version 2 a=
s<br>
&gt; =A0 * published by the Free Software Foundation.<br>
&gt; =A0 */<br>
&gt; -#undef DEBUG<br>
&gt; +//#undef DEBUG<br>
&gt; +#define DEBUG<br>
<br>
</div>trailing... but you know that :-p<br></blockquote><div><br></div><div=
>yes true.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; @@ -254,14 +255,14 @@ void omap2_clk_disable(struct clk *clk)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;clock: %s: decrementing usecount\n&quot;, clk=
-&gt;name);<br>
&gt; +// =A0 pr_debug(&quot;clock: %s: decrementing usecount\n&quot;, clk-&=
gt;name);<br>
&gt;<br>
&gt; =A0 =A0 =A0 clk-&gt;usecount--;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (clk-&gt;usecount &gt; 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;clock: %s: disabling in hardware\n&quot;, clk=
-&gt;name);<br>
&gt; +// =A0 pr_debug(&quot;clock: %s: disabling in hardware\n&quot;, clk-&=
gt;name);<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (clk-&gt;ops &amp;&amp; clk-&gt;ops-&gt;disable) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_disable(clk-&gt;name, 0, smp_p=
rocessor_id());<br>
<br>
</div>this hunk is unnecessary. Clocks are always on when they are called.<=
br></blockquote><div><br></div><div>The problem is:</div><div><br></div><di=
v>[1]:</div><div><br></div><div>runtime_put -&gt; *power.lock* - &gt; rpm-&=
gt;suspend -&gt; above pr_debug -&gt; console_write -&gt; get_sync</div>

<div><br></div><div>-&gt; *power.lock* -&gt; rpm resume</div><div><br></div=
><div>power.lock contention.</div><div><br></div><div>=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex;">


<div class=3D"im"><br>
&gt; @@ -290,14 +291,14 @@ int omap2_clk_enable(struct clk *clk)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 int ret;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;clock: %s: incrementing usecount\n&quot;, clk=
-&gt;name);<br>
&gt; +// =A0 pr_debug(&quot;clock: %s: incrementing usecount\n&quot;, clk-&=
gt;name);<br>
&gt;<br>
&gt; =A0 =A0 =A0 clk-&gt;usecount++;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (clk-&gt;usecount &gt; 1)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;clock: %s: enabling in hardware\n&quot;, clk-=
&gt;name);<br>
&gt; +// =A0 pr_debug(&quot;clock: %s: enabling in hardware\n&quot;, clk-&g=
t;name);<br>
<br>
</div>these two is ok.<br>
<div class=3D"im"><br>
&gt; diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/om=
ap_hwmod.c<br>
&gt; index 7ed0479..8ca7d40 100644<br>
&gt; --- a/arch/arm/mach-omap2/omap_hwmod.c<br>
&gt; +++ b/arch/arm/mach-omap2/omap_hwmod.c<br>
&gt; @@ -124,7 +124,8 @@<br>
&gt; =A0 * XXX error return values should be checked to ensure that they ar=
e<br>
&gt; =A0 * appropriate<br>
&gt; =A0 */<br>
&gt; -#undef DEBUG<br>
&gt; +//#undef DEBUG<br>
&gt; +#define DEBUG<br>
<br>
</div>trailing.<br>
<div class=3D"im"><br>
&gt; @@ -597,7 +598,8 @@ static int _enable_clocks(struct omap_hwmod *oh)<b=
r>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 int i;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_hwmod: %s: enabling clocks\n&quot;, oh-&=
gt;name);<br>
&gt; + =A0 =A0 if (strcmp(oh-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %s: enabling cloc=
ks\n&quot;, oh-&gt;name);<br>
<br>
</div>instead of doing checks, you could move the print to the end of the<b=
r>
function, when clocks are already enabled. When doind that, of course,<br>
update the comment to say &quot;%s: clocks enabled\n&quot;.<br></blockquote=
><div><br></div><div><br></div><div>the problem is the prints causing power=
.lock contention same as=A0</div><div>the=A0scenario=A0in [1] above.</div><=
div>

<br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; @@ -627,7 +629,8 @@ static int _disable_clocks(struct omap_hwmod *oh)<=
br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 int i;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_hwmod: %s: disabling clocks\n&quot;, oh-=
&gt;name);<br>
&gt; + =A0 =A0 if (strcmp(oh-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %s: disabling clo=
cks\n&quot;, oh-&gt;name);<br>
<br>
</div>check not needed, clocks are still on.<br></blockquote><div><br></div=
><div>scenario=A0[1]</div><div><br></div><div>=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex;">


<div class=3D"im"><br>
&gt;<br>
&gt; =A0 =A0 =A0 if (oh-&gt;_clk)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(oh-&gt;_clk);<br>
&gt; @@ -1232,7 +1235,8 @@ static int _enable(struct omap_hwmod *oh)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_hwmod: %s: enabling\n&quot;, oh-&gt;name=
);<br>
&gt; + =A0 =A0 if (strcmp(oh-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %s: enabling\n&qu=
ot;, oh-&gt;name);<br>
<br>
</div>move it further down.<br>
<div class=3D"im"><br>
&gt; @@ -1264,8 +1268,9 @@ static int _enable(struct omap_hwmod *oh)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 } else {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 _disable_clocks(oh);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %s: _wait_target_=
ready: %d\n&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh-&gt;name, r);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(oh-&gt;class-&gt;name, &quot;uart=
&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %=
s: _wait_target_ready: %d\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh-&gt;na=
me, r);<br>
<br>
</div>instead of adding check, move the print before _disable_clocks(oh).<b=
r>
<div class=3D"im"><br>
&gt; @@ -1287,7 +1292,8 @@ static int _idle(struct omap_hwmod *oh)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_hwmod: %s: idling\n&quot;, oh-&gt;name);=
<br>
&gt; + =A0 =A0 if (strcmp(oh-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_hwmod: %s: idling\n&quot=
;, oh-&gt;name);<br>
<br>
</div>I believe clocks are still on here too, no checks needed.<br>
<div class=3D"im"><br>
&gt; diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/oma=
p_device.c<br>
&gt; index 49fc0df..7b27704 100644<br>
&gt; --- a/arch/arm/plat-omap/omap_device.c<br>
&gt; +++ b/arch/arm/plat-omap/omap_device.c<br>
&gt; @@ -75,7 +75,8 @@<br>
&gt; =A0 * (device must be reinitialized at this point to use it again)<br>
&gt; =A0 *<br>
&gt; =A0 */<br>
&gt; -#undef DEBUG<br>
&gt; +//#undef DEBUG<br>
&gt; +#define DEBUG<br>
<br>
</div>trailing.<br>
<div class=3D"im"><br>
&gt; @@ -114,7 +115,8 @@ static int _omap_device_activate(struct<br>
&gt; omap_device *od, u8 ignore_lat)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct timespec a, b, c;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_device: %s: activating\n&quot;, od-&gt;<=
a href=3D"http://pdev.name" target=3D"_blank">pdev.name</a>);<br>
&gt; + =A0 =A0 if (strcmp(od-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&q=
uot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: %s: activating\n=
&quot;, od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name</a>=
);<br>
<br>
</div>move it to the end of the function.<br>
<div class=3D"im"><br>
&gt; @@ -138,25 +140,29 @@ static int _omap_device_activate(struct<br>
&gt; omap_device *od, u8 ignore_lat)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D timespec_sub(b, a);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 act_lat =3D timespec_to_ns(&amp;c);<br>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: %s: pm_lat %d: a=
ctivate: elapsed time &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%llu nsec\n&quot;, =
od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name</a>, od-&gt=
;pm_lat_level,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0act_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(od-&gt;hwmods[0]-&gt;class-&gt;na=
me, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: =
%s: pm_lat %d: activate: elapsed time &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%ll=
u nsec\n&quot;, od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.=
name</a>, od-&gt;pm_lat_level,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0act_lat);=
<br>
<br>
</div>move it further down.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (act_lat &gt; odpl-&gt;activate_lat) {<=
br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl-&gt;activate_lat_wors=
t =3D act_lat;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (odpl-&gt;flags &amp; O=
MAP_DEVICE_LATENCY_AUTO_ADJUST) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl-&gt;a=
ctivate_lat =3D act_lat;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&=
quot;omap_device: %s.%d: new worst case &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&quot;activate latency %d: %llu\n&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name<=
/a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</a>,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;pm_lat_level, act_lat);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&=
quot;omap_device: %s.%d: activate &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&quot;latency %d higher than exptected. &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&quot;(%llu &gt; %d)\n&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name<=
/a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</a>,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;pm_lat_level, act_lat,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0odpl-&gt;activate_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(o=
d-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning(&quot;omap_device: %s.%d: new worst case &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;activate latency %d: %llu\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">p=
dev.name</a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</=
a>,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 od-&gt;pm_lat_level, act_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(o=
d-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning(&quot;omap_device: %s.%d: activate &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;latency %d higher than exptected. &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;(%llu &gt; %d)\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">p=
dev.name</a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</=
a>,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 od-&gt;pm_lat_level, act_lat,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 odpl-&gt;activate_lat);<br>
<br>
</div></div>-&gt;activate_func() has already been called here, clocks are a=
lready on.<br>
<div class=3D"im"><br>
&gt; @@ -183,7 +189,8 @@ static int _omap_device_deactivate(struct<br>
&gt; omap_device *od, u8 ignore_lat)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct timespec a, b, c;<br>
&gt;<br>
&gt; - =A0 =A0 pr_debug(&quot;omap_device: %s: deactivating\n&quot;, od-&gt=
;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name</a>);<br>
&gt; + =A0 =A0 if (strcmp(od-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&q=
uot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: %s: deactivating=
\n&quot;, od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name</=
a>);<br>
<br>
</div>clocks are still on here.<br>
<div class=3D"im"><br>
&gt; @@ -206,25 +213,29 @@ static int _omap_device_deactivate(struct<br>
&gt; omap_device *od, u8 ignore_lat)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D timespec_sub(b, a);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 deact_lat =3D timespec_to_ns(&amp;c);<br>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: %s: pm_lat %d: d=
eactivate: elapsed time &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%llu nsec\n&quot;, =
od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name</a>, od-&gt=
;pm_lat_level,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0deact_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(od-&gt;hwmods[0]-&gt;class-&gt;na=
me, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;omap_device: =
%s: pm_lat %d: deactivate: elapsed time &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;%ll=
u nsec\n&quot;, od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.=
name</a>, od-&gt;pm_lat_level,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0deact_lat=
);<br>
<br>
</div>I&#39;ll leave this to Kevin to decide what to do, but clocks are off=
<br>
here...<br></blockquote><div><br></div><div>Yes fine.=A0</div><div><br></di=
v><div>Since most of these prints will be printed if DEBUG macro</div><div>=
is defined in respective files and *debug* is used in command line.</div>

<div><br></div><div>Can&#39;t leave uart clocks active always on debug case=
s.</div><div>[If *debug* =A0used as command line]</div><div>and gate uart c=
locks only for non debug cases.</div><div><br></div><div>With this approach=
=A0at least=A0we can have a clean solution</div>

<div>in uart driver also without adding clock gating from idle path.</div><=
div><br></div><div>Not sure if this=A0agreeable.</div><div><br></div><div>A=
s of now gating from idle path seems to be only clean approach.</div><div>

<br></div><div>--=A0</div><div>Thanks,</div><div>Govindraj.R</div><div><br>=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (deact_lat &gt; odpl-&gt;deactivate_lat=
) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl-&gt;deactivate_lat_wo=
rst =3D deact_lat;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (odpl-&gt;flags &amp; O=
MAP_DEVICE_LATENCY_AUTO_ADJUST) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl-&gt;d=
eactivate_lat =3D deact_lat;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&=
quot;omap_device: %s.%d: new worst case &quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&quot;deactivate latency %d: %llu\n&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.name<=
/a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</a>,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0od-&gt;pm_lat_level, deact_lat);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&=
quot;omap_device: %s.%d: deactivate &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(o=
d-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning(&quot;omap_device: %s.%d: new worst case &quot;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;deactivate latency %d: %llu\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0od-&gt;<a href=3D"http://pdev.name" target=3D"_b=
lank">pdev.name</a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pd=
ev.id</a>,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0od-&gt;pm_lat_level, deact_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(o=
d-&gt;hwmods[0]-&gt;class-&gt;name, &quot;uart&quot;))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning(&quot;omap_device: %s.%d: deactivate &quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&quot;latency %d higher than exptected. &quot;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&quot;(%llu &gt; %d)\n&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od-&gt;<a href=3D"http://pdev.name" target=3D"_blank">pdev.n=
ame</a>, od-&gt;<a href=3D"http://pdev.id" target=3D"_blank">pdev.id</a>,<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0od-&gt;pm_lat_level, deact_lat,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0odpl-&gt;deactivate_lat);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
<br>
</div>and here...<br>
<br>
--<br>
<font color=3D"#888888">balbi<br>
</font></blockquote></div><br>

--20cf3010edafb65b8c04a96ea735--

--===============7872865836262816405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7872865836262816405==--
