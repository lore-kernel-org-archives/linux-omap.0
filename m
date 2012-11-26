From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
 flag
Date: Mon, 26 Nov 2012 15:25:42 +0530
Message-ID: <CAM=Q2csBvUxHGTH_CMiZ56tcmHZDRHgTjaEB9=s+RJx-Mwa5pA@mail.gmail.com>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
 <20121126091400.GD15766@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7266320129988448506=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121126091400.GD15766@arwen.pp.htv.fi>
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
Cc: w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7266320129988448506==
Content-Type: multipart/alternative; boundary=047d7b603e74bdea9904cf62effb

--047d7b603e74bdea9904cf62effb
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 26, 2012 at 2:44 PM, Felipe Balbi <balbi@ti.com> wrote:

> > +     .flags          = OMAP_I2C_FLAG_BUS_SHIFT_2,
>
> if it's not used anymore, how about removing its definition too ?


yes just updated the patch. Thanks.

--047d7b603e74bdea9904cf62effb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Nov 26, 2012 at 2:44 PM, Felipe =
Balbi <span dir=3D"ltr">&lt;<a href=3D"mailto:balbi@ti.com" target=3D"_blan=
k">balbi@ti.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">&gt; + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OMAP_I2C_FLA=
G_BUS_SHIFT_2,<br>
<br>
</div>if it&#39;s not used anymore, how about removing its definition too ?=
</blockquote></div><br><div>yes just updated the patch. Thanks.</div>

--047d7b603e74bdea9904cf62effb--


--===============7266320129988448506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7266320129988448506==--
