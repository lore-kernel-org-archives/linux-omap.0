From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Tue, 10 May 2011 09:50:07 +0530
Message-ID: <BANLkTik9MJST+KYSPbfoFF4X8_1w_Bmgqw@mail.gmail.com>
References: <1304944530-12998-1-git-send-email-govindraj.raja@ti.com>
	<1304944530-12998-2-git-send-email-govindraj.raja@ti.com>
	<BANLkTi==XOX0EkeKB3_z7LwpZvU2RRXkqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355793534=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTi==XOX0EkeKB3_z7LwpZvU2RRXkqA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1355793534==
Content-Type: multipart/alternative; boundary=bcaec517a88a927acf04a2e4467a

--bcaec517a88a927acf04a2e4467a
Content-Type: text/plain; charset=ISO-8859-1

On Mon, May 9, 2011 at 10:26 PM, Todd Poynor <toddpoynor@google.com> wrote:

> On Mon, May 9, 2011 at 5:35 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
>
>> Add API to enable IO pad wakeup capability based on mux dynamic pad and
>> wake_up enable flag available from hwmod_mux initialization.
>>
>> Use the wakeup_enable flag and enable wakeup capability
>> for the given pads. Wakeup capability will be enabled/disabled
>> during hmwod idle transition based on whether wakeup_flag is
>> set or cleared.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod.c              |   51
>> +++++++++++++++++++++++++
>>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +
>>  arch/arm/plat-omap/omap_device.c              |   50
>> ++++++++++++++++++++++++
>>  4 files changed, 106 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index e034294..bbbe1ed 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2369,3 +2369,54 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod
>> *oh)
>>
>>        return 0;
>>  }
>> +
>> +static int omap_hwmod_configure_ioring_wakeup(struct omap_hwmod *oh, u16
>> val)
>> +{
>> +       struct omap_device_pad *pad;
>> +       int ret = -EINVAL, j;
>> +
>> +       if (oh->mux->enabled) {
>> +               for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
>> +                       pad = oh->mux->pads_dynamic[j];
>> +                       if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
>> +                               pad->idle = pad->enable | val;
>> +                               ret = 0;
>> +                       }
>> +               }
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * omap_hwmod_enable_ioring_wakeup - Set wakeup flag for iopad.
>> + * @oh: struct omap_hwmod *
>> + *
>> + * Traverse through dynamic pads, if pad is enabled then
>> + * set wakeup enable bit flag for the mux pin. Wakeup pad bit
>> + * will be set during hwmod idle transistion.
>> + * Return error if pads are not enabled or not available.
>> + */
>> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh)
>> +{
>> +       /* Enable pad wake-up capability */
>> +       return omap_hwmod_configure_ioring_wakeup(oh, OMAP_WAKEUP_EN);
>> +}
>> +
>> +/**
>> + * omap_hwmod_disable_ioring_wakeup - Clear wakeup flag for iopad.
>> + * @oh: struct omap_hwmod *
>> + *
>> + * Traverse through dynamic pads, if pad is enabled then
>> + * clear wakeup enable bit flag for the mux pin. Wakeup pad bit
>> + * will be set during hwmod idle transistion.
>> + * Return error if pads are not enabled or not available.
>> + */
>> +int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)
>> +{
>> +       u16 val = 0;
>> +
>> +       /* Disable pad wakeup capability */
>> +       val &= ~OMAP_WAKEUP_EN;
>>
>
> Will still leave val  = 0.
>
> It sounds like omap_hwmod_configure_ioring_wakeup needs to take a new value
> for the OMAP_WAKEUP_EN bit (0 or 1), and that code needs to set pad->idle
> = pad->enable | OMAP_WAKEUP_EN if being enabled, or pad->idle =
> pad->enable & ~OMAP_WAKEUP_EN if being disabled?
>


yes fine.
will change and post out v3.



>
>> +       return omap_hwmod_configure_ioring_wakeup(oh, val);
>>
>> +}
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
>> b/arch/arm/plat-omap/include/plat/omap_device.h
>> index e4c349f..a377dd0 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -117,6 +117,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>>  int omap_device_disable_clocks(struct omap_device *od);
>>  int omap_device_enable_clocks(struct omap_device *od);
>>
>> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev);
>> +int omap_device_disable_ioring_wakeup(struct platform_device *pdev);
>>
>>  /*
>>  * Entries should be kept in latency order ascending
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 1adea9c..7ef11a6 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -602,6 +602,9 @@ u32 omap_hwmod_get_context_loss_count(struct
>> omap_hwmod *oh);
>>
>>  int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>>
>> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh);
>> +int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh);
>> +
>>  /*
>>  * Chip variant-specific hwmod init routines - XXX should be converted
>>  * to use initcalls once the initial boot ordering is straightened out
>> diff --git a/arch/arm/plat-omap/omap_device.c
>> b/arch/arm/plat-omap/omap_device.c
>> index 9bbda9a..04a4f15 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -742,6 +742,56 @@ void __iomem *omap_device_get_rt_va(struct
>> omap_device *od)
>>        return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>>  }
>>
>> +/**
>> + * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
>> + * @pdev: platform_device for which wakeup needs to be set.
>> + *
>> + * Caller should ensure this is called if device_may_wakeup(dev) is true
>> + * traverse through each hwmod and check each available pads
>> + * if pad is enabled then set wakeup enable flag for the mux pin.
>> + * Return error if pads are not enabled or not available.
>> + * Wakeup enable flag will be we used during hwmod idle transistion.
>> + */
>> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev)
>> +{
>> +       int ret = -EINVAL, i;
>> +       struct omap_device *od;
>> +       struct omap_hwmod *oh;
>> +
>> +       od = _find_by_pdev(pdev);
>> +       for (i = 0; i < od->hwmods_cnt; i++) {
>> +               oh = od->hwmods[i];
>> +               ret = omap_hwmod_enable_ioring_wakeup(oh);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * omap_device_disable_ioring_wakeup - Clear wakeup bit for iopad ring.
>> + * @pdev: platform_device for which wakeup needs to be cleared.
>> + *
>> + * Caller should ensure this is called if device_may_wakeup(dev) is false
>> + * traverse through each hwmod and check each available pads
>> + * if pad is enabled then clear wakeup enable flag for the mux pin.
>> + * Return error if pads are not enabled or not available.
>> + * Wakeup enable flag will be we used during hwmod idle transistion.
>> + */
>> +int omap_device_disable_ioring_wakeup(struct platform_device *pdev)
>> +{
>> +       int ret = -EINVAL, i;
>> +       struct omap_device *od;
>> +       struct omap_hwmod *oh;
>> +
>> +       od = _find_by_pdev(pdev);
>> +       for (i = 0; i < od->hwmods_cnt; i++) {
>> +               oh = od->hwmods[i];
>> +               ret = omap_hwmod_disable_ioring_wakeup(oh);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  /*
>>  * Public functions intended for use in omap_device_pm_latency
>>  * .activate_func and .deactivate_func function pointers
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>

--bcaec517a88a927acf04a2e4467a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, May 9, 2011 at 10:26 PM, Todd Po=
ynor <span dir=3D"ltr">&lt;<a href=3D"mailto:toddpoynor@google.com">toddpoy=
nor@google.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"gmail_quote"><div><div></div><div class=3D"h5">On Mon, May 9,=
 2011 at 5:35 AM, Govindraj.R <span dir=3D"ltr">&lt;<a href=3D"mailto:govin=
draj.raja@ti.com" target=3D"_blank">govindraj.raja@ti.com</a>&gt;</span> wr=
ote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Add API to enable IO pad wakeup capability based on mux dynamic pad and<br>
wake_up enable flag available from hwmod_mux initialization.<br>
<br>
Use the wakeup_enable flag and enable wakeup capability<br>
for the given pads. Wakeup capability will be enabled/disabled<br>
during hmwod idle transition based on whether wakeup_flag is<br>
set or cleared.<br>
<br>
Signed-off-by: Govindraj.R &lt;<a href=3D"mailto:govindraj.raja@ti.com" tar=
get=3D"_blank">govindraj.raja@ti.com</a>&gt;<br>
---<br>
=A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 51 +++=
++++++++++++++++++++++<br>
=A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A02 +<br>
=A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A03 +<br>
=A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 50 +++=
+++++++++++++++++++++<br>
=A04 files changed, 106 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c<br>
index e034294..bbbe1ed 100644<br>
--- a/arch/arm/mach-omap2/omap_hwmod.c<br>
+++ b/arch/arm/mach-omap2/omap_hwmod.c<br>
@@ -2369,3 +2369,54 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)=
<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
+<br>
+static int omap_hwmod_configure_ioring_wakeup(struct omap_hwmod *oh, u16 v=
al)<br>
+{<br>
+ =A0 =A0 =A0 struct omap_device_pad *pad;<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL, j;<br>
+<br>
+ =A0 =A0 =A0 if (oh-&gt;mux-&gt;enabled) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j &lt; oh-&gt;mux-&gt;nr_pads_d=
ynamic; j++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad =3D oh-&gt;mux-&gt;pads_d=
ynamic[j];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pad-&gt;flags &amp; OMAP_=
DEVICE_PAD_WAKEUP) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad-&gt;idle =
=3D pad-&gt;enable | val;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * omap_hwmod_enable_ioring_wakeup - Set wakeup flag for iopad.<br>
+ * @oh: struct omap_hwmod *<br>
+ *<br>
+ * Traverse through dynamic pads, if pad is enabled then<br>
+ * set wakeup enable bit flag for the mux pin. Wakeup pad bit<br>
+ * will be set during hwmod idle transistion.<br>
+ * Return error if pads are not enabled or not available.<br>
+ */<br>
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh)<br>
+{<br>
+ =A0 =A0 =A0 /* Enable pad wake-up capability */<br>
+ =A0 =A0 =A0 return omap_hwmod_configure_ioring_wakeup(oh, OMAP_WAKEUP_EN)=
;<br>
+}<br>
+<br>
+/**<br>
+ * omap_hwmod_disable_ioring_wakeup - Clear wakeup flag for iopad.<br>
+ * @oh: struct omap_hwmod *<br>
+ *<br>
+ * Traverse through dynamic pads, if pad is enabled then<br>
+ * clear wakeup enable bit flag for the mux pin. Wakeup pad bit<br>
+ * will be set during hwmod idle transistion.<br>
+ * Return error if pads are not enabled or not available.<br>
+ */<br>
+int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)<br>
+{<br>
+ =A0 =A0 =A0 u16 val =3D 0;<br>
+<br>
+ =A0 =A0 =A0 /* Disable pad wakeup capability */<br>
+ =A0 =A0 =A0 val &amp;=3D ~OMAP_WAKEUP_EN;<br></blockquote><div><br></div>=
</div></div><div>Will still leave val =A0=3D 0.</div><div><br></div><div>It=
 sounds like=A0omap_hwmod_configure_ioring_wakeup needs to take a new value=
 for the OMAP_WAKEUP_EN bit (0 or 1), and that code needs to set pad-&gt;id=
le =3D=A0pad-&gt;enable |=A0OMAP_WAKEUP_EN if being enabled, or=A0pad-&gt;i=
dle =3D pad-&gt;enable=A0&amp; ~OMAP_WAKEUP_EN if being disabled?</div>

</div></blockquote><div><br></div><div><br></div><div>yes fine.</div><div>w=
ill change and post out v3.</div><div><br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex;">

<div class=3D"gmail_quote">
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
+ =A0 =A0 =A0 return omap_hwmod_configure_ioring_wakeup(oh, val);<div><div>=
</div><div class=3D"h5"><br>
+}<br>
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-=
omap/include/plat/omap_device.h<br>
index e4c349f..a377dd0 100644<br>
--- a/arch/arm/plat-omap/include/plat/omap_device.h<br>
+++ b/arch/arm/plat-omap/include/plat/omap_device.h<br>
@@ -117,6 +117,8 @@ int omap_device_enable_hwmods(struct omap_device *od);<=
br>
=A0int omap_device_disable_clocks(struct omap_device *od);<br>
=A0int omap_device_enable_clocks(struct omap_device *od);<br>
<br>
+int omap_device_enable_ioring_wakeup(struct platform_device *pdev);<br>
+int omap_device_disable_ioring_wakeup(struct platform_device *pdev);<br>
<br>
=A0/*<br>
 =A0* Entries should be kept in latency order ascending<br>
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h<br>
index 1adea9c..7ef11a6 100644<br>
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h<br>
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h<br>
@@ -602,6 +602,9 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod=
 *oh);<br>
<br>
=A0int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);<br>
<br>
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh);<br>
+int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh);<br>
+<br>
=A0/*<br>
 =A0* Chip variant-specific hwmod init routines - XXX should be converted<b=
r>
 =A0* to use initcalls once the initial boot ordering is straightened out<b=
r>
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_dev=
ice.c<br>
index 9bbda9a..04a4f15 100644<br>
--- a/arch/arm/plat-omap/omap_device.c<br>
+++ b/arch/arm/plat-omap/omap_device.c<br>
@@ -742,6 +742,56 @@ void __iomem *omap_device_get_rt_va(struct omap_device=
 *od)<br>
 =A0 =A0 =A0 =A0return omap_hwmod_get_mpu_rt_va(od-&gt;hwmods[0]);<br>
=A0}<br>
<br>
+/**<br>
+ * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.<br>
+ * @pdev: platform_device for which wakeup needs to be set.<br>
+ *<br>
+ * Caller should ensure this is called if device_may_wakeup(dev) is true<b=
r>
+ * traverse through each hwmod and check each available pads<br>
+ * if pad is enabled then set wakeup enable flag for the mux pin.<br>
+ * Return error if pads are not enabled or not available.<br>
+ * Wakeup enable flag will be we used during hwmod idle transistion.<br>
+ */<br>
+int omap_device_enable_ioring_wakeup(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL, i;<br>
+ =A0 =A0 =A0 struct omap_device *od;<br>
+ =A0 =A0 =A0 struct omap_hwmod *oh;<br>
+<br>
+ =A0 =A0 =A0 od =3D _find_by_pdev(pdev);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; od-&gt;hwmods_cnt; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D od-&gt;hwmods[i];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_enable_ioring_wakeup(oh);<=
br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * omap_device_disable_ioring_wakeup - Clear wakeup bit for iopad ring.<br=
>
+ * @pdev: platform_device for which wakeup needs to be cleared.<br>
+ *<br>
+ * Caller should ensure this is called if device_may_wakeup(dev) is false<=
br>
+ * traverse through each hwmod and check each available pads<br>
+ * if pad is enabled then clear wakeup enable flag for the mux pin.<br>
+ * Return error if pads are not enabled or not available.<br>
+ * Wakeup enable flag will be we used during hwmod idle transistion.<br>
+ */<br>
+int omap_device_disable_ioring_wakeup(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL, i;<br>
+ =A0 =A0 =A0 struct omap_device *od;<br>
+ =A0 =A0 =A0 struct omap_hwmod *oh;<br>
+<br>
+ =A0 =A0 =A0 od =3D _find_by_pdev(pdev);<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; od-&gt;hwmods_cnt; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D od-&gt;hwmods[i];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_disable_ioring_wakeup(oh);=
<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
=A0/*<br>
 =A0* Public functions intended for use in omap_device_pm_latency<br>
 =A0* .activate_func and .deactivate_func function pointers<br>
--<br>
1.7.1<br>
</div></div><font color=3D"#888888"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-omap&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></blockquote></div><br>
</blockquote></div><br>

--bcaec517a88a927acf04a2e4467a--


--===============1355793534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1355793534==--
