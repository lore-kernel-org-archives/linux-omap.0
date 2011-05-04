From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 6/8] OMAP2+: omap_device: implement the constraints
	management code
Date: Wed, 4 May 2011 15:11:38 -0700
Message-ID: <BANLkTinVCLiXYoPcP905Fhv2ejUH1QfLBw@mail.gmail.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-7-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1617160347=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1304516117-9334-7-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jean.pihet@newoldbits.com
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1617160347==
Content-Type: multipart/alternative; boundary=0015174becd46449ef04a27a8afa

--0015174becd46449ef04a27a8afa
Content-Type: text/plain; charset=ISO-8859-1

On Wed, May 4, 2011 at 6:35 AM, <jean.pihet@newoldbits.com> wrote:

> ...
> diff --git a/arch/arm/plat-omap/omap_device.c
> b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..1d075cb 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -292,10 +292,196 @@ static void _add_optional_clock_clkdev(struct
> omap_device *od,
>        }
>  }
>
> +/* Spinlock that protects the constraints lists */
> +static spinlock_t _constraints_lock;
> +
> +/*
> + * _store_constraint: add/update/remove a constraint from a plist. There
> is
> + *  one plist per omap_device.
> + *
> + * @constraints_list: plist to use
> + * @req_dev: constraint requester, used to track the requests
> + * @dev: device constraint target, used to track the requests
> + * @value: constraint value. The plist is sorted by the value. -1 remove
> the
> + *  constraint from the list
> + * @ascending: return the lowest constraint value if set to 1, return the
> + *  highest value if not.
> + *
> + * Tracks the constraints by req_dev and dev.
> + * Returns the strongest constraint value for the given device, 0 in the
> + * case there is no constraint or a negative value in case of error.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +static long _store_constraint(struct plist_head *constraints_list,
> +                             struct device *req_dev, struct device *dev,
> +                             long value, int ascending)
> +{
> +       struct omap_device_constraints_entry *user = NULL, *tmp_user;
> +       int ret = 0;
> +       unsigned long flags;
> +
> +       /* Check if there already is a constraint for dev and req_dev */
> +       spin_lock_irqsave(&_constraints_lock, flags);
> +       plist_for_each_entry(tmp_user, constraints_list, node) {
> +               if ((tmp_user->req_dev == req_dev) && (tmp_user->dev ==
> dev)) {
> +                       user = tmp_user;
> +                       break;
> +               }
> +       }
> +       spin_unlock_irqrestore(&_constraints_lock, flags);
> +
> +       if (value >= 0) {
> +               /* Nothing to update, job done */
> +               if (user && (user->node.prio == value))
> +                       goto exit_ok;
> +
> +               /* Add new entry to the list or update existing request */
> +               if (!user) {
> +                       user = kzalloc(
> +                               sizeof(struct
> omap_device_constraints_entry),
> +                               GFP_KERNEL);
> +                       if (!user) {
> +                               pr_err("%s: FATAL ERROR: kzalloc failed\n",
> +                                      __func__);
> +                               ret = -ENOMEM;
> +                               goto exit_error;
> +                       }
> +                       user->req_dev = req_dev;
> +                       user->dev = dev;
> +               } else {
> +                       spin_lock_irqsave(&_constraints_lock, flags);
> +                       plist_del(&user->node, constraints_list);
>

spinlock was dropped, no ref counting, not safe to assume user is still
valid.


> +                       spin_unlock_irqrestore(&_constraints_lock, flags);
> +               }
> +
> +               spin_lock_irqsave(&_constraints_lock, flags);
> +               plist_node_init(&user->node, value);
>

and user may be invalid here


> +               plist_add(&user->node, constraints_list);
> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +       } else {
> +               /* Remove the constraint from the list */
> +               if (!user) {
> +                       pr_err("%s: Error: no prior constraint to
> release\n",
> +                              __func__);
> +                       ret = -EINVAL;
> +                       goto exit_error;
> +               }
> +
> +               spin_lock_irqsave(&_constraints_lock, flags);
> +               plist_del(&user->node, constraints_list);
>

and here


> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +               kfree(user);
> +       }
> +
> +exit_ok:
> +       /* Find the strongest constraint for the given device */
> +       if (!plist_head_empty(constraints_list)) {
> +               spin_lock_irqsave(&_constraints_lock, flags);
>

Deref of plist_first/last() should happen after a plist_head_empty() check
with the spinlock held.


> +               if (ascending) {
> +                       /* Find the lowest (i.e. first) value */
> +                       ret = plist_first(constraints_list)->prio;
> +               } else {
> +                       /* Find the highest (i.e. last) value */
> +                       ret = plist_last(constraints_list)->prio;
> +               }
> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +       }
> +
> +exit_error:
> +       return ret;
> +}
> ...
>

Todd

--0015174becd46449ef04a27a8afa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, May 4, 2011 at 6:35 AM,  <span dir=3D"lt=
r">&lt;<a href=3D"mailto:jean.pihet@newoldbits.com">jean.pihet@newoldbits.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
...<br>
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c<br>
index 9bbda9a..1d075cb 100644<br>
--- a/arch/arm/plat-omap/omap_device.c<br>
+++ b/arch/arm/plat-omap/omap_device.c<br>
@@ -292,10 +292,196 @@ static void _add_optional_clock_clkdev(struct omap_d=
evice *od,<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
+/* Spinlock that protects the constraints lists */<br>
+static spinlock_t _constraints_lock;<br>
+<br>
+/*<br>
+ * _store_constraint: add/update/remove a constraint from a plist. There i=
s<br>
+ * =A0one plist per omap_device.<br>
+ *<br>
+ * @constraints_list: plist to use<br>
+ * @req_dev: constraint requester, used to track the requests<br>
+ * @dev: device constraint target, used to track the requests<br>
+ * @value: constraint value. The plist is sorted by the value. -1 remove t=
he<br>
+ * =A0constraint from the list<br>
+ * @ascending: return the lowest constraint value if set to 1, return the<=
br>
+ * =A0highest value if not.<br>
+ *<br>
+ * Tracks the constraints by req_dev and dev.<br>
+ * Returns the strongest constraint value for the given device, 0 in the<b=
r>
+ * case there is no constraint or a negative value in case of error.<br>
+ *<br>
+ * The caller must check the validity of the parameters.<br>
+ */<br>
+static long _store_constraint(struct plist_head *constraints_list,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device *re=
q_dev, struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long value, int a=
scending)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_device_constraints_entry *user =3D NULL, *tmp_use=
r;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 unsigned long flags;<br>
+<br>
+ =A0 =A0 =A0 /* Check if there already is a constraint for dev and req_dev=
 */<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;_constraints_lock, flags);<br>
+ =A0 =A0 =A0 plist_for_each_entry(tmp_user, constraints_list, node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tmp_user-&gt;req_dev =3D=3D req_dev) &am=
p;&amp; (tmp_user-&gt;dev =3D=3D dev)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D tmp_user;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;_constraints_lock, flags);<br>
+<br>
+ =A0 =A0 =A0 if (value &gt;=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Nothing to update, job done */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user &amp;&amp; (user-&gt;node.prio =3D=
=3D value))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ok;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the list or update existi=
ng request */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D kzalloc(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct=
 omap_device_constraints_entry),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;=
%s: FATAL ERROR: kzalloc failed\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__func__);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOM=
EM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_err=
or;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user-&gt;req_dev =3D req_dev;=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user-&gt;dev =3D dev;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;_const=
raints_lock, flags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&amp;user-&gt;node,=
 constraints_list);<br></blockquote><div><br></div><div>spinlock was droppe=
d, no ref counting, not safe to assume user is still valid.</div><div>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;_=
constraints_lock, flags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;_constraints_lock, fla=
gs);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&amp;user-&gt;node, value);<b=
r></blockquote><div><br></div><div>and user may be invalid here</div><div>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&amp;user-&gt;node, constraints_lis=
t);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;_constraints_lock=
, flags);<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove the constraint from the list */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;%s: Error: no pr=
ior constraint to release\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;_constraints_lock, fla=
gs);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&amp;user-&gt;node, constraints_lis=
t);<br></blockquote><div><br></div><div>and here</div><div>=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;_constraints_lock=
, flags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+exit_ok:<br>
+ =A0 =A0 =A0 /* Find the strongest constraint for the given device */<br>
+ =A0 =A0 =A0 if (!plist_head_empty(constraints_list)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&amp;_constraints_lock, fla=
gs);<br></blockquote><div><br></div><div>Deref of plist_first/last() should=
 happen after a=A0plist_head_empty() check with the spinlock held.</div><di=
v>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ascending) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find the lowest (i.e. firs=
t) value */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D plist_first(constrain=
ts_list)-&gt;prio;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find the highest (i.e. las=
t) value */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D plist_last(constraint=
s_list)-&gt;prio;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;_constraints_lock=
, flags);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+exit_error:<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
...<br></blockquote><div><br></div><div>Todd</div><div><br></div></div>

--0015174becd46449ef04a27a8afa--


--===============1617160347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1617160347==--
