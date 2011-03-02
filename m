From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH] omap:iommu-added cache flushing operation for L2 cache
Date: Wed, 2 Mar 2011 09:46:55 -0600
Message-ID: <AANLkTikyLQ4ZxM+dK5c09964VLA_TLxV12Y1jqXJhOC-@mail.gmail.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
	<1dc497a090414bf80ff588791d6db5cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1535586188=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1dc497a090414bf80ff588791d6db5cc@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux@arm.linux.org.uk, Fernando Guzman Lugo <fernando.lugo@ti.com>, tony@atomide.com, hiroshi.doyu@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1535586188==
Content-Type: multipart/alternative; boundary=0016e68deb9f91ecc7049d81d2c6

--0016e68deb9f91ecc7049d81d2c6
Content-Type: text/plain; charset=ISO-8859-1

Hi Santosh,


On Wed, Mar 2, 2011 at 6:48 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com>wrote:

> Hello,
>  > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Fernando Guzman Lugo
> > Sent: Wednesday, March 02, 2011 1:17 AM
> > To: hiroshi.doyu@nokia.com
> > Cc: tony@atomide.com; linux@arm.linux.org.uk; linux-
> > omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Ramesh Gupta; Hari Kanigeri
> > Subject: [PATCH] omap:iommu-added cache flushing operation for L2
> > cache
> >
> > From: Ramesh Gupta <grgupta@ti.com>
> >
> > Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/plat-omap/iommu.c |   22 ++++++++--------------
> >  1 files changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> > index e3eb038..aeb2c33 100644
> > --- a/arch/arm/plat-omap/iommu.c
> > +++ b/arch/arm/plat-omap/iommu.c
> > @@ -471,22 +471,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);
> >   */
> >  static void flush_iopgd_range(u32 *first, u32 *last)
> >  {
> > -     /* FIXME: L2 cache should be taken care of if it exists */
> > -     do {
> > -             asm("mcr        p15, 0, %0, c7, c10, 1 @ flush_pgd"
> > -                 : : "r" (first));
> > -             first += L1_CACHE_BYTES / sizeof(*first);
> > -     } while (first <= last);
> > +     dmac_flush_range(first, last);
>
> There is note just above this API.
>

Thank you for your comment. I agree, I will send an updated patch with
proper apis.

regards
Ramesh Gupta G

--0016e68deb9f91ecc7049d81d2c6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Santosh,</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">On Wed, Mar 2, 2011 at 6:48 AM, Santosh Shilimka=
r <span dir=3D"ltr">&lt;<a href=3D"mailto:santosh.shilimkar@ti.com">santosh=
.shilimkar@ti.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hello,<br>
<div>
<div></div>
<div class=3D"h5">&gt; -----Original Message-----<br>&gt; From: <a href=3D"=
mailto:linux-omap-owner@vger.kernel.org">linux-omap-owner@vger.kernel.org</=
a> [mailto:<a href=3D"mailto:linux-omap-">linux-omap-</a><br>&gt; <a href=
=3D"mailto:owner@vger.kernel.org">owner@vger.kernel.org</a>] On Behalf Of F=
ernando Guzman Lugo<br>
&gt; Sent: Wednesday, March 02, 2011 1:17 AM<br>&gt; To: <a href=3D"mailto:=
hiroshi.doyu@nokia.com">hiroshi.doyu@nokia.com</a><br>&gt; Cc: <a href=3D"m=
ailto:tony@atomide.com">tony@atomide.com</a>; <a href=3D"mailto:linux@arm.l=
inux.org.uk">linux@arm.linux.org.uk</a>; linux-<br>
&gt; <a href=3D"mailto:omap@vger.kernel.org">omap@vger.kernel.org</a>; <a h=
ref=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@lists.=
infradead.org</a>; linux-<br>&gt; <a href=3D"mailto:kernel@vger.kernel.org"=
>kernel@vger.kernel.org</a>; Ramesh Gupta; Hari Kanigeri<br>
&gt; Subject: [PATCH] omap:iommu-added cache flushing operation for L2<br>&=
gt; cache<br>&gt;<br>&gt; From: Ramesh Gupta &lt;<a href=3D"mailto:grgupta@=
ti.com">grgupta@ti.com</a>&gt;<br>&gt;<br>&gt; Signed-off-by: Ramesh Gupta =
&lt;<a href=3D"mailto:grgupta@ti.com">grgupta@ti.com</a>&gt;<br>
&gt; Signed-off-by: Hari Kanigeri &lt;<a href=3D"mailto:h-kanigeri2@ti.com"=
>h-kanigeri2@ti.com</a>&gt;<br>&gt; ---<br>&gt; =A0arch/arm/plat-omap/iommu=
.c | =A0 22 ++++++++--------------<br>&gt; =A01 files changed, 8 insertions=
(+), 14 deletions(-)<br>
&gt;<br>&gt; diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/i=
ommu.c<br>&gt; index e3eb038..aeb2c33 100644<br>&gt; --- a/arch/arm/plat-om=
ap/iommu.c<br>&gt; +++ b/arch/arm/plat-omap/iommu.c<br>&gt; @@ -471,22 +471=
,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);<br>
&gt; =A0 */<br>&gt; =A0static void flush_iopgd_range(u32 *first, u32 *last)=
<br>&gt; =A0{<br>&gt; - =A0 =A0 /* FIXME: L2 cache should be taken care of =
if it exists */<br>&gt; - =A0 =A0 do {<br>&gt; - =A0 =A0 =A0 =A0 =A0 =A0 as=
m(&quot;mcr =A0 =A0 =A0 =A0p15, 0, %0, c7, c10, 1 @ flush_pgd&quot;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : : &quot;r&quot; (first));<br>&gt; =
- =A0 =A0 =A0 =A0 =A0 =A0 first +=3D L1_CACHE_BYTES / sizeof(*first);<br>&g=
t; - =A0 =A0 } while (first &lt;=3D last);<br>&gt; + =A0 =A0 dmac_flush_ran=
ge(first, last);<br><br></div></div>
There is note just above this API.<br></blockquote>
<div>=A0</div>
<div>Thank you for your comment. I agree, I will send an updated patch with=
 </div>
<div>proper apis.</div></div><br clear=3D"all">regards=20
<div>Ramesh Gupta G</div><br>

--0016e68deb9f91ecc7049d81d2c6--


--===============1535586188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1535586188==--
