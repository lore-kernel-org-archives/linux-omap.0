From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Wed, 11 May 2011 09:36:12 -0700
Message-ID: <BANLkTin07ZkWwhMtqUEMhLtwugKNmhku9g@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0132076773=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0132076773==
Content-Type: multipart/alternative; boundary=001636d3467ab5122504a302ab66

--001636d3467ab5122504a302ab66
Content-Type: text/plain; charset=ISO-8859-1

On Wed, May 11, 2011 at 2:12 AM, Shweta Gulati <shweta.gulati@ti.com> wrote:
...

> diff --git a/arch/arm/mach-omap2/sr_device.c
> b/arch/arm/mach-omap2/sr_device.c
> index 2782d3f..65b2aae 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>        struct omap_sr_data *sr_data;
>        struct omap_device *od;
>        struct omap_volt_data *volt_data;
> +       struct omap_sr_dev_attr *sr_dev_attr;
>        char *name = "smartreflex";
>        static int i;
>
> @@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void
> *user)
>                return -ENOMEM;
>        }
>
> -       if (!oh->vdd_name) {
> +       sr_dev_attr = (struct omap_sr_dev_attr *)oh->dev_attr;
> +       if (!sr_dev_attr->voltdm_name) {
>                pr_err("%s: No voltage domain specified for %s."
>

Suggest if (!sr_dev_attr || !sr_dev_attr->voltdm_name) to catch this error.


> -                       "Cannot initialize\n", __func__, oh->name);
> +                               "Cannot initialize\n", __func__,
> +                                       sr_dev_attr->voltdm_name);
>

Should leave the hwmod's oh->name as the pr_err
param, sr_dev_attr->voltdm_name has just been verified bogus.


Todd

--001636d3467ab5122504a302ab66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, May 11, 2011 at 2:12 AM, Shweta Gulati <=
span dir=3D"ltr">&lt;<a href=3D"mailto:shweta.gulati@ti.com">shweta.gulati@=
ti.com</a>&gt;</span> wrote:<br><div>...=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex;">

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_devic=
e.c<br>
index 2782d3f..65b2aae 100644<br>
--- a/arch/arm/mach-omap2/sr_device.c<br>
+++ b/arch/arm/mach-omap2/sr_device.c<br>
@@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)=
<br>
 =A0 =A0 =A0 =A0struct omap_sr_data *sr_data;<br>
 =A0 =A0 =A0 =A0struct omap_device *od;<br>
 =A0 =A0 =A0 =A0struct omap_volt_data *volt_data;<br>
+ =A0 =A0 =A0 struct omap_sr_dev_attr *sr_dev_attr;<br>
 =A0 =A0 =A0 =A0char *name =3D &quot;smartreflex&quot;;<br>
 =A0 =A0 =A0 =A0static int i;<br>
<br>
@@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user=
)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 if (!oh-&gt;vdd_name) {<br>
+ =A0 =A0 =A0 sr_dev_attr =3D (struct omap_sr_dev_attr *)oh-&gt;dev_attr;<b=
r>
+ =A0 =A0 =A0 if (!sr_dev_attr-&gt;voltdm_name) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err(&quot;%s: No voltage domain specifie=
d for %s.&quot;<br></blockquote><div><br></div><div>Suggest if (!sr_dev_att=
r ||=A0!sr_dev_attr-&gt;voltdm_name) to catch this error.</div><div>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex;">

- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Cannot initialize\n&quo=
t;, __func__, oh-&gt;name);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Cannot =
initialize\n&quot;, __func__,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sr_dev_attr-&gt;voltdm_name);<br></blockquote><div><br></div><div>Shoul=
d leave the hwmod&#39;s oh-&gt;name as the pr_err param,=A0sr_dev_attr-&gt;=
voltdm_name has just been verified bogus.</div>
<div>=A0</div><div><br></div><div>Todd</div><div><br></div></div><br>

--001636d3467ab5122504a302ab66--


--===============0132076773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0132076773==--
