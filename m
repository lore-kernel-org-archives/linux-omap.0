From: "steve.zhan" <zhanzhenbo@gmail.com>
Subject: Re: [PATCH] hwspinlock/core: Add testing capabilities
Date: Sun, 30 Dec 2012 22:13:08 +0800
Message-ID: <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5915891397423034859=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121230112018.GA14042@WorkStation.localnet>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ido Yariv <ido@wizery.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5915891397423034859==
Content-Type: multipart/alternative; boundary=bcaec51d2f2627dd8c04d212806d

--bcaec51d2f2627dd8c04d212806d
Content-Type: text/plain; charset=ISO-8859-1

Hi,
   Acked-by: Steve zhan zhanzhenbo@gmail.com

   "I'd rather not test the spinlocks after they are registering as they
might already be in use by then."

    Why? I think user must use it after hwspin_lock_register have retured
sucess.


Steve


2012/12/30 Ido Yariv <ido@wizery.com>

> Hi Steve,
>
> On Sat, Dec 29, 2012 at 05:19:08PM +0800, steve.zhan wrote:
> > Hi,
> >
> >     It is good idea add this feature.
> >
> > 1: Can we let the "ret = hwspin_lock_tests(ops, hwlock);" add after
> > hwspin_lock_register_single have return
> > succeed, that can avoid test duplicated Or error lockid. Of course, If
> > this interface is intend to test soc hardware capability only, we can
> > put it in the arch module not this core framework. For driver hardware
> > sanity check, i would add it after software have register it.
>
> I'd rather not test the spinlocks after they are registering as they
> might already be in use by then.
>
> While this feature only verifies the underlying platform implementation,
> I think it's best to avoid code duplication and keep it in one place
> that will always get called.
>
> > 2:Is it possible that interface add configs that choose which locks
> > will be test? Because the hwspinlock module is init late in
> > postcore_initcall phase, Maybe MACH/ARCH code(for example: code in
> > early_initcall) need use private other interfaces to lock some
> > hwspinlocks and then register hw locks to hwspinlock framework, Maybe
> > some hw locks is in lock status but which test failed.
>
> It was assumed that up to the point where the hw spinlocks are
> registered they will not be used, regardless of when this module is
> initialized.
> If this assumption does not hold for your platform, the simplest
> solution would be to set this config option to 'N', as there is no safe
> way of verifying spinlocks that are actively being used.
>
> Thanks for reviewing this,
> Ido.
>



-- 
Steve Zhan

--bcaec51d2f2627dd8c04d212806d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br></div>=A0=A0 Acked-by: Steve zhan <a=
 href=3D"mailto:zhanzhenbo@gmail.com">zhanzhenbo@gmail.com</a><br>=A0<br>=
=A0=A0 &quot;I&#39;d rather not test the spinlocks after they are registeri=
ng as they<br>


might already be in use by then.&quot;<br><br></div>=A0=A0=A0 Why? I think =
user must use it after hwspin_lock_register have retured sucess.<br><br><br=
></div>Steve<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">

2012/12/30 Ido Yariv <span dir=3D"ltr">&lt;<a href=3D"mailto:ido@wizery.com=
" target=3D"_blank">ido@wizery.com</a>&gt;</span><br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">

Hi Steve,<br>
<div class=3D"im"><br>
On Sat, Dec 29, 2012 at 05:19:08PM +0800, steve.zhan wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; =A0 =A0 It is good idea add this feature.<br>
&gt;<br>
&gt; 1: Can we let the &quot;ret =3D hwspin_lock_tests(ops, hwlock);&quot; =
add after<br>
&gt; hwspin_lock_register_single have return<br>
&gt; succeed, that can avoid test duplicated Or error lockid. Of course, If=
<br>
&gt; this interface is intend to test soc hardware capability only, we can<=
br>
&gt; put it in the arch module not this core framework. For driver hardware=
<br>
&gt; sanity check, i would add it after software have register it.<br>
<br>
</div>I&#39;d rather not test the spinlocks after they are registering as t=
hey<br>
might already be in use by then.<br>
<br>
While this feature only verifies the underlying platform implementation,<br=
>
I think it&#39;s best to avoid code duplication and keep it in one place<br=
>
that will always get called.<br>
<div class=3D"im"><br>
&gt; 2:Is it possible that interface add configs that choose which locks<br=
>
&gt; will be test? Because the hwspinlock module is init late in<br>
&gt; postcore_initcall phase, Maybe MACH/ARCH code(for example: code in<br>
&gt; early_initcall) need use private other interfaces to lock some<br>
&gt; hwspinlocks and then register hw locks to hwspinlock framework, Maybe<=
br>
&gt; some hw locks is in lock status but which test failed.<br>
<br>
</div>It was assumed that up to the point where the hw spinlocks are<br>
registered they will not be used, regardless of when this module is<br>
initialized.<br>
If this assumption does not hold for your platform, the simplest<br>
solution would be to set this config option to &#39;N&#39;, as there is no =
safe<br>
way of verifying spinlocks that are actively being used.<br>
<br>
Thanks for reviewing this,<br>
Ido.<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Steve Zhan
</div>

--bcaec51d2f2627dd8c04d212806d--


--===============5915891397423034859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5915891397423034859==--
