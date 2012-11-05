From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 14:54:32 +0530
Message-ID: <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi> <50977A30.6040907@ti.com>
 <20121105090412.GA2913@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3413054393690845612=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121105090412.GA2913@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: b-cousson@ti.com, tony@atomide.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-omap@vger.kernel.org, Shubhrajyoti <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3413054393690845612==
Content-Type: multipart/alternative; boundary=f46d04016aa39f3dd904cdbc0de2

--f46d04016aa39f3dd904cdbc0de2
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> > >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > >>
> > >>            dev->fifo_size = (dev->fifo_size / 2);
> > >>
> > >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> > >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
> > >>                    dev->b_hw = 1; /* Enable hardware fixes */
> > > looks like this was applicable to 4430 too, what happened ?
> > No actually this can be deleted completely once the
> > start -> transaction -> stop sequence recommendation is followed.
>
> yes, but we're not there just yet and this patch is changing the
> behavior of the driver


No , earlier we were truncating the register for omap4 so
OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
omap4 then we donot find 3630 and 4430 value to be similar.

In this case the behavior is same as earlier also it enabled this for lower
than 3630 and
the same holds good even now.

So in essence,
Earlier  OMAP_I2C_REV_ON_3630_4430 is named to OMAP_I2C_REV_ON_3630
and omap4 rev will have a 32bit value.




> in ways which don't belong to $SUBJECT.
>
> --
> balbi
>

--f46d04016aa39f3dd904cdbc0de2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon, N=
ov 5, 2012 at 2:34 PM, Felipe Balbi <span dir=3D"ltr">&lt;<a href=3D"mailto=
:balbi@ti.com" target=3D"_blank">balbi@ti.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">

Hi,<br>
<div><br>
On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:<br>
&gt; &gt;&gt; @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *=
pdev)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0dev-&gt;fifo_size =3D (dev-&gt;fifo_si=
ze / 2);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - =A0 =A0 =A0 =A0 =A0if (dev-&gt;rev &lt; OMAP_I2C_REV_ON_363=
0_4430)<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0if (dev-&gt;rev &lt; OMAP_I2C_REV_ON_363=
0)<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-&gt;b_hw =3D 1; /*=
 Enable hardware fixes */<br>
&gt; &gt; looks like this was applicable to 4430 too, what happened ?<br>
&gt; No actually this can be deleted completely once the<br>
&gt; start -&gt; transaction -&gt; stop sequence recommendation is followed=
.<br>
<br>
</div>yes, but we&#39;re not there just yet and this patch is changing the<=
br>
behavior of the driver</blockquote><div><br></div><div>No , earlier we were=
 truncating the register for omap4 so=A0</div><div>OMAP_I2C_REV_ON_3630_443=
0 was there if we read both hi and lo for=A0</div><div>omap4 then we donot =
find 3630 and 4430 value to be similar.</div>
<div><br></div><div>In this case the behavior is same as earlier also it en=
abled this for lower than 3630 and=A0</div><div>the same holds good even no=
w.</div><div><br></div><div>So in essence,</div><div>Earlier=A0=A0OMAP_I2C_=
REV_ON_3630_4430 is named to=A0OMAP_I2C_REV_ON_3630=A0</div>
<div>and omap4 rev will have a 32bit value.</div><div><br></div><div><br></=
div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"> in ways which don&#39;t b=
elong to $SUBJECT.<br>

<span><font color=3D"#888888"><br>
--<br>
balbi<br>
</font></span></blockquote></div><br></div>

--f46d04016aa39f3dd904cdbc0de2--


--===============3413054393690845612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3413054393690845612==--
