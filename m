From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 21:26:42 +0530
Message-ID: <CAAe_U6Jw7WrWRAQrVF0XTwBp+F4Fw0zCFVxoZmWdBLSjUS+_Hw@mail.gmail.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4392300150193289585=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4392300150193289585==
Content-Type: multipart/alternative; boundary=20cf307c9bd2c07a6504c38a602b

--20cf307c9bd2c07a6504c38a602b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Wed, Jun 27, 2012 at 11:11 AM, N, Mugunthan V <mugunthanvnm@ti.com>wrote:

> > -----Original Message-----
> > From: N, Mugunthan V
> > Sent: Thursday, June 07, 2012 9:52 PM
> > To: 'linux-omap@vger.kernel.org'
> > Cc: 'linux-arm-kernel@lists.infradead.org'
> > Subject: how to specify dma_mask and coherent_dma_mask in hwmod
> >
> > Hi
> >
> > While converting platform device registry to Hwmod for CPSW Ethernet
> > driver which is present in AM335X (OMAP2+), I am not finding a way to
> > specify
> > dma_mask and coherent_dma_mask.
> > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
>

Nope. You can specify dma_mask after creating the device as done in
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/usb-musb.c;h=c4a576856661014ea3bec9acc70f80e32d62c33b;hb=HEAD

Regards
Kishon

--20cf307c9bd2c07a6504c38a602b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br><div class=3D"gmail_quote">On Wed, Jun 27, 2012 at 11:11 AM, N, =
Mugunthan V <span dir=3D"ltr">&lt;<a href=3D"mailto:mugunthanvnm@ti.com" ta=
rget=3D"_blank">mugunthanvnm@ti.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
&gt; -----Original Message-----<br>
&gt; From: N, Mugunthan V<br>
&gt; Sent: Thursday, June 07, 2012 9:52 PM<br>
&gt; To: &#39;<a href=3D"mailto:linux-omap@vger.kernel.org">linux-omap@vger=
.kernel.org</a>&#39;<br>
&gt; Cc: &#39;<a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux=
-arm-kernel@lists.infradead.org</a>&#39;<br>
&gt; Subject: how to specify dma_mask and coherent_dma_mask in hwmod<br>
&gt;<br>
&gt; Hi<br>
&gt;<br>
&gt; While converting platform device registry to Hwmod for CPSW Ethernet<b=
r>
&gt; driver which is present in AM335X (OMAP2+), I am not finding a way to<=
br>
&gt; specify<br>
&gt; dma_mask and coherent_dma_mask.<br>
&gt; Is there a way to specify dma_mask and coherent_dma_mask in hwmod?<br>=
</blockquote><div><br></div><div>Nope. You can specify dma_mask after creat=
ing the device as done in</div><div><a href=3D"http://git.kernel.org/?p=3Dl=
inux/kernel/git/torvalds/linux.git;a=3Dblob;f=3Darch/arm/mach-omap2/usb-mus=
b.c;h=3Dc4a576856661014ea3bec9acc70f80e32d62c33b;hb=3DHEAD">http://git.kern=
el.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=3Darch/arm/mach-=
omap2/usb-musb.c;h=3Dc4a576856661014ea3bec9acc70f80e32d62c33b;hb=3DHEAD</a>
</div><div><br></div><div>Regards</div><div>Kishon</div></div>

--20cf307c9bd2c07a6504c38a602b--


--===============4392300150193289585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4392300150193289585==--
