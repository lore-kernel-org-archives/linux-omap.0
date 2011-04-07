From: "Mahadeva, Avinash" <avinashhm@ti.com>
Subject: Re: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout during
	bootup
Date: Thu, 7 Apr 2011 12:12:37 +0530
Message-ID: <BANLkTikrDS_U5u7=2z6ZNiWVcb6W8GoOTg@mail.gmail.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
	<1302018015-8858-2-git-send-email-avinashhm@ti.com>
	<87mxk4zh7u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0374941514=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mxk4zh7u.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============0374941514==
Content-Type: multipart/alternative; boundary=20cf303f69ea428dcc04a04e6a1a

--20cf303f69ea428dcc04a04e6a1a
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Apr 5, 2011 at 11:57 PM, Kevin Hilman <khilman@ti.com> wrote:

> "Avinash.H.M" <avinashhm@ti.com> writes:
>
> > The i2c module has a special reset sequence. The sequence is
> > - Disable the I2C.
> > - Write to SOFTRESET bit.
> > - Enable the I2C.
> > - Poll on the RESETDONE bit.
> > This sequence must be followed for i2c reset in omap2, omap3. The
> sequence is
> > implemented as a function and the i2c_class is updated with the correct
> > 'reset' pointer.
> >
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
>
> [...]
>
> > +
> > +/**
> > + * omap_i2c_reset- reset the omap i2c module.
> > + * @oh: struct omap_hwmod *
> > + *
> > + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> > + * sequence is:
> > + * - Disable the I2C.
> > + * - Write to SOFTRESET bit.
> > + * - Enable the I2C.
> > + * - Poll on the RESETDONE bit.
> > + * The sequence is implemented in below function. This is called for
> 2420,
> > + * 2430 and omap3.
> > + */
> > +int omap_i2c_reset(struct omap_hwmod *oh)
> > +{
> > +     u32 v;
> > +     int c = 0;
> > +
> > +     /* Disable I2C */
> > +     v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> > +     v = v & ~I2C_EN;
> > +     omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> > +
> > +     /* Write to the SOFTRESET bit */
> > +     v = oh->_sysc_cache;
> > +     v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> > +
> > +     oh->_sysc_cache = v;
> > +     omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
>
> Direct SYSCONFIG access isn't right here.   This should go through
> omap_hwmod.
>
> What is probably needed is exposing _ocp_softreset to device code
> via something like omap_hwmod_ocp_softreset() and calling that here.
>
>
Hi Kevin ,

thanks for the review.

OK. I ll create a wrapper function ' omap_hwmod_ocp_softreset'
around '_ocp_softreset' and call it here .

b r ,
- avinash.



> Kevin
>

--20cf303f69ea428dcc04a04e6a1a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Apr 5, 2011 at 11:57 PM, Kevin H=
ilman <span dir=3D"ltr">&lt;<a href=3D"mailto:khilman@ti.com">khilman@ti.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">
<div class=3D"im">&quot;Avinash.H.M&quot; &lt;<a href=3D"mailto:avinashhm@t=
i.com">avinashhm@ti.com</a>&gt; writes:<br>
<br>
&gt; The i2c module has a special reset sequence. The sequence is<br>
&gt; - Disable the I2C.<br>
&gt; - Write to SOFTRESET bit.<br>
&gt; - Enable the I2C.<br>
&gt; - Poll on the RESETDONE bit.<br>
&gt; This sequence must be followed for i2c reset in omap2, omap3. The sequ=
ence is<br>
&gt; implemented as a function and the i2c_class is updated with the correc=
t<br>
&gt; &#39;reset&#39; pointer.<br>
&gt;<br>
&gt; Cc: Rajendra Nayak &lt;<a href=3D"mailto:rnayak@ti.com">rnayak@ti.com<=
/a>&gt;<br>
&gt; Cc: Paul Walmsley &lt;<a href=3D"mailto:paul@pwsan.com">paul@pwsan.com=
</a>&gt;<br>
&gt; Cc: Benoit Cousson &lt;<a href=3D"mailto:b-cousson@ti.com">b-cousson@t=
i.com</a>&gt;<br>
&gt; Cc: Kevin Hilman &lt;<a href=3D"mailto:khilman@ti.com">khilman@ti.com<=
/a>&gt;<br>
&gt; Signed-off-by: Avinash.H.M &lt;<a href=3D"mailto:avinashhm@ti.com">avi=
nashhm@ti.com</a>&gt;<br>
<br>
</div>[...]<br>
<div class=3D"im"><br>
&gt; +<br>
&gt; +/**<br>
&gt; + * omap_i2c_reset- reset the omap i2c module.<br>
&gt; + * @oh: struct omap_hwmod *<br>
&gt; + *<br>
&gt; + * The i2c moudle in omap2, omap3 had a special sequence to reset. Th=
e<br>
&gt; + * sequence is:<br>
&gt; + * - Disable the I2C.<br>
&gt; + * - Write to SOFTRESET bit.<br>
&gt; + * - Enable the I2C.<br>
&gt; + * - Poll on the RESETDONE bit.<br>
&gt; + * The sequence is implemented in below function. This is called for =
2420,<br>
&gt; + * 2430 and omap3.<br>
&gt; + */<br>
&gt; +int omap_i2c_reset(struct omap_hwmod *oh)<br>
&gt; +{<br>
&gt; + =A0 =A0 u32 v;<br>
&gt; + =A0 =A0 int c =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 /* Disable I2C */<br>
&gt; + =A0 =A0 v =3D omap_hwmod_read(oh, I2C_CON_OFFSET);<br>
&gt; + =A0 =A0 v =3D v &amp; ~I2C_EN;<br>
&gt; + =A0 =A0 omap_hwmod_write(v, oh, I2C_CON_OFFSET);<br>
&gt; +<br>
&gt; + =A0 =A0 /* Write to the SOFTRESET bit */<br>
&gt; + =A0 =A0 v =3D oh-&gt;_sysc_cache;<br>
&gt; + =A0 =A0 v |=3D (0x1 &lt;&lt; oh-&gt;class-&gt;sysc-&gt;sysc_fields-&=
gt;srst_shift);<br>
&gt; +<br>
&gt; + =A0 =A0 oh-&gt;_sysc_cache =3D v;<br>
&gt; + =A0 =A0 omap_hwmod_write(v, oh, oh-&gt;class-&gt;sysc-&gt;sysc_offs)=
;<br>
<br>
</div>Direct SYSCONFIG access isn&#39;t right here. =A0 This should go thro=
ugh<br>
omap_hwmod.<br>
<br>
What is probably needed is exposing _ocp_softreset to device code<br>
via something like omap_hwmod_ocp_softreset() and calling that here.<br>
<font color=3D"#888888"><br></font></blockquote><div><br>Hi Kevin , <br><br=
>thanks for the review. <br><br>OK. I ll create a wrapper function &#39; om=
ap_hwmod_ocp_softreset&#39;<br>around &#39;_ocp_softreset&#39; and call it =
here .<br>
</div><div><br>b r ,<br>- avinash.<br><br>=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(20=
4, 204, 204); padding-left: 1ex;"><font color=3D"#888888">
Kevin<br>
</font></blockquote></div><br>

--20cf303f69ea428dcc04a04e6a1a--


--===============0374941514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0374941514==--
