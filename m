From: Jello huang <ruifeihuang@gmail.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Fri, 23 Nov 2012 18:07:13 +0800
Message-ID: <CAPFyZi4HPRg==bbyW93wtKmR5qG3fOqK_VNGuVGz0tpQ8QrxfA@mail.gmail.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A5E801.3000100@ti.com>
 <20121120221456.GO18567@atomide.com>
 <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
 <50AE2E15.2070501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1640678215382799562=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50AE2E15.2070501@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1640678215382799562==
Content-Type: multipart/alternative; boundary=20cf307abcf96738b704cf26bf9a

--20cf307abcf96738b704cf26bf9a
Content-Type: text/plain; charset=ISO-8859-1

hi
Sorry donot describe clearly.
>>How do you allocate CMA memory from userspace
 memory is allocated by userland then  pass the size to kernel space

I mean that we can split two parts of memory heap .one for the kernel space
and other for userland app. we can use dma_declare_contiguous to declare
one dma device A and B .Then the all kernel driver allocate from A .The
other B allocate for userland


On 22 November 2012 21:52, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Hi,
>
> On 2012-11-21 16:22, Jello huang wrote:
> > HI Tomi,
> > we need  one rank of cma to allocate the memory for driver in kernel
> > space .And the default CMA is for allocating memory frome usespace.So
> > if we allocate the memory from the
> > default CMA zone ,there maybe introduce fragmention to the default CMA
> > zone.The kernel space memory donot touch the memory from userspace
>
> Can you elaborate a bit? I didn't understand your point. Are you saying
> each kernel driver that uses dma_alloc should have their own CMA zone?
> That doesn't make sense...
>
> How do you allocate CMA memory from userspace?
>
>  Tomi
>
>
>


-- 
Thanks
Jello Huang

--20cf307abcf96738b704cf26bf9a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi<div>Sorry donot describe clearly.<div><span style=3D"font-family:arial,s=
ans-serif;font-size:12.727272033691406px">&gt;&gt;How do you allocate CMA m=
emory from userspace</span><br></div><div>=A0memory is allocated by userlan=
d then =A0pass the size to kernel space=A0</div>

<div>=A0</div><div>I mean that we can split two parts of memory heap .one f=
or the kernel space and other for userland app. we can use=A0<span style=3D=
"white-space:pre-wrap">dma_declare_contiguous to declare one dma device A a=
nd B .Then the all </span><span style=3D"font-family:arial,sans-serif;font-=
size:12.727272033691406px">kernel driver allocate from A .The other B alloc=
ate for userland=A0</span></div>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On 22 N=
ovember 2012 21:52, Tomi Valkeinen <span dir=3D"ltr">&lt;<a href=3D"mailto:=
tomi.valkeinen@ti.com" target=3D"_blank">tomi.valkeinen@ti.com</a>&gt;</spa=
n> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div><br>
On 2012-11-21 16:22, Jello huang wrote:<br>
&gt; HI Tomi,<br>
&gt; we need =A0one rank of cma to allocate the memory for driver in kernel=
<br>
&gt; space .And the default CMA is for allocating memory frome usespace.So<=
br>
&gt; if we allocate the memory from the<br>
&gt; default CMA zone ,there maybe introduce fragmention to the default CMA=
<br>
&gt; zone.The kernel space memory donot touch the memory from userspace<br>
<br>
</div>Can you elaborate a bit? I didn&#39;t understand your point. Are you =
saying<br>
each kernel driver that uses dma_alloc should have their own CMA zone?<br>
That doesn&#39;t make sense...<br>
<br>
How do you allocate CMA memory from userspace?<br>
<span><font color=3D"#888888"><br>
=A0Tomi<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Thanks<div>Jello Huang</div><br>
</div>

--20cf307abcf96738b704cf26bf9a--


--===============1640678215382799562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1640678215382799562==--
