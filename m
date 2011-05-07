From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 1/2] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Sat, 7 May 2011 10:54:34 -0700
Message-ID: <BANLkTikoYy1E2vyFjR-fKqOsC7B-xWDWbw@mail.gmail.com>
References: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com>
	<1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1413983645=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1413983645==
Content-Type: multipart/alternative; boundary=00151748dd7c991b8404a2b34c40

--00151748dd7c991b8404a2b34c40
Content-Type: text/plain; charset=ISO-8859-1

On Fri, May 6, 2011 at 3:09 AM, Govindraj.R <govindraj.raja@ti.com> wrote:

> ...
> +
> +/**
> + * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @oh: struct omap_hwmod *
> + * @enable: based on 0 or 1 set or unset wakeup bit.
> + *
> + * Traverse through dynamic pads, if pad is enabled then
> + * set wakeup enable bit flag for the mux pin. Wakeup pad bit
> + * will be set during hwmod idle transistion.
> + * Return error if pads are not enabled or not available.
> + */
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
> +{
> +       struct omap_device_pad *pad;
> +       int ret = -EINVAL, j;
> +       int val = 0;
> +
> +       /* Enable pin mux to make pad wake-up capable */
> +       if (enable)
> +               val = OMAP_WAKEUP_EN;
> +       else
> +               val = ~OMAP_WAKEUP_EN;
> +
> +       if (oh->mux->enabled) {
> +               for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
> +                       pad = oh->mux->pads_dynamic[j];
> +                       if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
> +                               pad->idle = pad->enable | val;
>

I haven't gone to find the patch uses the pad->idle value (or the TRM docs),
but the !enable case that OR's in every bit except for OMAP_WAKEUP_EN seems
strange, should the non-wakeup-enabled idle value for the pad set all other
bits in that reg?

..

Todd

--00151748dd7c991b8404a2b34c40
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, May 6, 2011 at 3:09 AM, Govindraj.R <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:govindraj.raja@ti.com">govindraj.raja@t=
i.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
...<br>
+<br>
+/**<br>
+ * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.<br>
+ * @oh: struct omap_hwmod *<br>
+ * @enable: based on 0 or 1 set or unset wakeup bit.<br>
+ *<br>
+ * Traverse through dynamic pads, if pad is enabled then<br>
+ * set wakeup enable bit flag for the mux pin. Wakeup pad bit<br>
+ * will be set during hwmod idle transistion.<br>
+ * Return error if pads are not enabled or not available.<br>
+ */<br>
+int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)<br=
>
+{<br>
+ =A0 =A0 =A0 struct omap_device_pad *pad;<br>
+ =A0 =A0 =A0 int ret =3D -EINVAL, j;<br>
+ =A0 =A0 =A0 int val =3D 0;<br>
+<br>
+ =A0 =A0 =A0 /* Enable pin mux to make pad wake-up capable */<br>
+ =A0 =A0 =A0 if (enable)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D OMAP_WAKEUP_EN;<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D ~OMAP_WAKEUP_EN;<br>
+<br>
+ =A0 =A0 =A0 if (oh-&gt;mux-&gt;enabled) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j &lt; oh-&gt;mux-&gt;nr_pads_d=
ynamic; j++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad =3D oh-&gt;mux-&gt;pads_d=
ynamic[j];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pad-&gt;flags &amp; OMAP_=
DEVICE_PAD_WAKEUP) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pad-&gt;idle =
=3D pad-&gt;enable | val;<br></blockquote><div><br></div><div>I haven&#39;t=
 gone to find the patch uses the pad-&gt;idle value (or the TRM docs), but =
the !enable case that OR&#39;s in every bit except for=A0OMAP_WAKEUP_EN see=
ms strange, should the non-wakeup-enabled idle value for the pad set all ot=
her bits in that reg?</div>
<div><br></div><div>..</div><div><br></div><div>Todd</div><div>=A0</div></d=
iv>

--00151748dd7c991b8404a2b34c40--


--===============1413983645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1413983645==--
