From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Fri, 17 Feb 2012 15:14:52 -0600
Message-ID: <CABT81PgzVEcRMBpZdQX8ymmTf5MJPruNmQytuHMEF-8AE2c7Hg@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<4F1D97CF.60306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1818249106=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <4F1D97CF.60306@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>, Rob Clark <rob@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1818249106==
Content-Type: multipart/alternative; boundary=f46d0401697581040504b92f6f20

--f46d0401697581040504b92f6f20
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 23, 2012 at 11:24 AM, Cousson, Benoit <b-cousson@ti.com> wrote:

>
>> +       if (oh) {
>> +               dmm_platdata.base = omap_hwmod_get_mpu_rt_va(oh);
>> +               dmm_platdata.irq = oh->mpu_irqs[0].irq;
>>
>
> These are internal hwmod attributes that should not be retrieved here.
> They are included in the device resources and this is up to the driver to
> get them using the platform_get_resource.


Yeah this can be removed and I can switch to platform_get_resource.



>  +
>> +               if (dmm_platdata.base)
>> +                       omapdrm_platdata.dmm_pdata =&dmm_platdata;
>>
>
> pdata is supposed to be used for storing board level information, and we
> are in the process of removing all of them for device tree adaptation. So
> you should not use that at all in this case if this is not strictly needed.


Noted.  I'll just remove it.  I was planning ahead when I added this, but I
can cross that bridge when I get there.


>
>  +       }
>> +
>> +       return platform_device_register(&**omap_drm_device);
>>
>
> This is not the proper way to init a device nowadays.
>
> If you want to take advantage of the pm functionality, you should create
> an omap_device.
> Please have a look at the other OMAP devices creation code (GPIO, UART...).


It was my understanding that you needed a hwmod entry that corresponded to
the device if you wanted to use omap_device_build().  In the case of
omap_drm, we don't have a hwmod entry.  We do have an entry for DMM.


Regards,

Andy Gross

--f46d0401697581040504b92f6f20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 23, 2012 at 11:24 AM, Cousso=
n, Benoit <span dir=3D"ltr">&lt;<a href=3D"mailto:b-cousson@ti.com">b-couss=
on@ti.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
+ =A0 =A0 =A0 if (oh) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.base =3D omap_hwmod_get_mpu_rt_v=
a(oh);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmm_platdata.irq =3D oh-&gt;mpu_irqs[0].irq;<=
br>
</blockquote>
<br></div>
These are internal hwmod attributes that should not be retrieved here. They=
 are included in the device resources and this is up to the driver to get t=
hem using the platform_get_resource.</blockquote><div><br></div><div>Yeah t=
his can be removed and I can switch to platform_get_resource.</div>
<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"i=
m">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmm_platdata.base)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omapdrm_platdata.dmm_pdata =
=3D&amp;dmm_platdata;<br>
</blockquote>
<br></div>
pdata is supposed to be used for storing board level information, and we ar=
e in the process of removing all of them for device tree adaptation. So you=
 should not use that at all in this case if this is not strictly needed.</b=
lockquote>
<div><br></div><div>Noted. =A0I&#39;ll just remove it. =A0I was planning ah=
ead when I added this, but I can cross that bridge when I get there.=A0</di=
v><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return platform_device_register(&amp;<u></u>omap_drm_device);=
<br>
</blockquote>
<br></div>
This is not the proper way to init a device nowadays.<br>
<br>
If you want to take advantage of the pm functionality, you should create an=
 omap_device.<br>
Please have a look at the other OMAP devices creation code (GPIO, UART...).=
</blockquote><div><br></div><div>It was my understanding that you needed a =
hwmod entry that corresponded to the device if you wanted to use omap_devic=
e_build(). =A0In the case of omap_drm, we don&#39;t have a hwmod entry. =A0=
We do have an entry for DMM.</div>
<div><br></div><div><br></div><div>Regards,</div><div><br></div><div>Andy G=
ross</div></div>

--f46d0401697581040504b92f6f20--

--===============1818249106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1818249106==--
