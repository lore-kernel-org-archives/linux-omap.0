From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup timer and
	debug counters
Date: Tue, 29 Mar 2011 11:57:15 +0530
Message-ID: <AANLkTikbBWn0KrUmAwTbEtY8K_g-xT2r9BqZU49iiOsb@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-15-git-send-email-santosh.shilimkar@ti.com>
	<20110328210046.GE30616@atomide.com>
	<4287119fdbc364dd7bd414ee40c1a9a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0504585096=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4287119fdbc364dd7bd414ee40c1a9a4@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============0504585096==
Content-Type: multipart/alternative; boundary=000e0cd517c8f91343049f992751

--000e0cd517c8f91343049f992751
Content-Type: text/plain; charset=ISO-8859-1

Sorry for spamming your inbox with same email. :(
Looks like my mailer has srewed up. It send same messege almost 20 times and
it shows me that it has
stuck in outbox

Regards
Santosh

On Tue, Mar 29, 2011 at 11:20 AM, Santosh Shilimkar <
santosh.shilimkar@ti.com> wrote:

> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Tuesday, March 29, 2011 2:31 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; khilman@ti.com; rnayak@ti.com;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup
> > timer and debug counters
> >
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:21]:
> > > --- a/arch/arm/mach-omap2/pm-debug.c
> > > +++ b/arch/arm/mach-omap2/pm-debug.c
> > > @@ -40,6 +41,11 @@ static int omap4_pm_suspend(void)
> > >     int state, ret = 0;
> > >     u32 cpu_id = smp_processor_id();
> > >
> > > +   /* Wakeup timer from suspend */
> > > +   if (wakeup_timer_seconds || wakeup_timer_milliseconds)
> > > +           omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
> > > +                                    wakeup_timer_milliseconds);
> > > +
> > >     /* Save current powerdomain state */
> > >     list_for_each_entry(pwrst, &pwrst_list, node) {
> > >             pwrst->saved_state = pwrdm_read_next_pwrst(pwrst-
> > >pwrdm);
> >
> > This hack to mess diretly with sys_timer will be ripped out,
> > so please drop this patch.
> >
> Ok.
>
> > In the long run we'll have dmtimer1 dedicated to the PM code,
> > so then it's possible to do similar things.
> >
>
> Regards,
> Santosh
>

--000e0cd517c8f91343049f992751
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry for spamming your inbox with same email. :(<br>Looks like my mailer h=
as srewed up. It send same messege almost 20 times and it shows me that it =
has<br>stuck in outbox<br><br>Regards<br>Santosh<br><br><div class=3D"gmail=
_quote">

On Tue, Mar 29, 2011 at 11:20 AM, Santosh Shilimkar <span dir=3D"ltr">&lt;<=
a href=3D"mailto:santosh.shilimkar@ti.com">santosh.shilimkar@ti.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0p=
t 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"=
>

<div class=3D"im">&gt; -----Original Message-----<br>
&gt; From: Tony Lindgren [mailto:<a href=3D"mailto:tony@atomide.com">tony@a=
tomide.com</a>]<br>
&gt; Sent: Tuesday, March 29, 2011 2:31 AM<br>
&gt; To: Santosh Shilimkar<br>
&gt; Cc: <a href=3D"mailto:linux-omap@vger.kernel.org">linux-omap@vger.kern=
el.org</a>; <a href=3D"mailto:khilman@ti.com">khilman@ti.com</a>; <a href=
=3D"mailto:rnayak@ti.com">rnayak@ti.com</a>;<br>
&gt; <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kern=
el@lists.infradead.org</a><br>
&gt; Subject: Re: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup<br>
&gt; timer and debug counters<br>
&gt;<br>
</div><div class=3D"im">&gt; * Santosh Shilimkar &lt;<a href=3D"mailto:sant=
osh.shilimkar@ti.com">santosh.shilimkar@ti.com</a>&gt; [110328 02:21]:<br>
&gt; &gt; --- a/arch/arm/mach-omap2/pm-debug.c<br>
&gt; &gt; +++ b/arch/arm/mach-omap2/pm-debug.c<br>
&gt; &gt; @@ -40,6 +41,11 @@ static int omap4_pm_suspend(void)<br>
&gt; &gt; =A0 =A0 int state, ret =3D 0;<br>
&gt; &gt; =A0 =A0 u32 cpu_id =3D smp_processor_id();<br>
&gt; &gt;<br>
&gt; &gt; + =A0 /* Wakeup timer from suspend */<br>
&gt; &gt; + =A0 if (wakeup_timer_seconds || wakeup_timer_milliseconds)<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 omap2_pm_wakeup_on_timer(wakeup_timer_secon=
ds,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0wakeup_timer_milliseconds);<br>
&gt; &gt; +<br>
&gt; &gt; =A0 =A0 /* Save current powerdomain state */<br>
&gt; &gt; =A0 =A0 list_for_each_entry(pwrst, &amp;pwrst_list, node) {<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 pwrst-&gt;saved_state =3D pwrdm_read_next=
_pwrst(pwrst-<br>
&gt; &gt;pwrdm);<br>
&gt;<br>
&gt; This hack to mess diretly with sys_timer will be ripped out,<br>
&gt; so please drop this patch.<br>
&gt;<br>
</div>Ok.<br>
<div class=3D"im"><br>
&gt; In the long run we&#39;ll have dmtimer1 dedicated to the PM code,<br>
&gt; so then it&#39;s possible to do similar things.<br>
&gt;<br>
<br>
</div>Regards,<br>
<font color=3D"#888888">Santosh<br>
</font></blockquote></div><br>

--000e0cd517c8f91343049f992751--


--===============0504585096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0504585096==--
