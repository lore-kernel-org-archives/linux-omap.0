From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 6 Mar 2012 09:50:32 -0600
Message-ID: <CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	<1331044544.2059.150.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0325796738=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1331044544.2059.150.camel@deskari>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, patches@linaro.org, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>
List-Id: linux-omap@vger.kernel.org

--===============0325796738==
Content-Type: multipart/alternative; boundary=f46d040123bdc66fe704ba9500b8

--f46d040123bdc66fe704ba9500b8
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>wrote:
>
>
> I have to say I don't know much about DMM, but my understanding is that
> DMM is a bigger entity, of which TILER is only a small part, and DMM
> manages all memory accesses.
>
> Can there be other users for the DMM than DRM? I know there could be
> other users for the TILER, and I know you want to combine that with the
> DRM driver, but I'm wondering about the other parts of DMM than the
> TILER.
>
> Somehow having a DMM driver inside omapdrm sounds strange.


The DMM does indeed contain a number of entities.  However, the TILER
portion is the only part that requires a driver.  All other register
modifications (LISA map settings, EMIF, etc) are done statically in the
loader or u-boot and never changed again.  As such, DMM has become
synonymous with TILER.

Regards,

Andy

--f46d040123bdc66fe704ba9500b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Mar 6, 2012 at 8:35 AM, Tomi Val=
keinen <span dir=3D"ltr">&lt;<a href=3D"mailto:tomi.valkeinen@ti.com">tomi.=
valkeinen@ti.com</a>&gt;</span> wrote:<blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br></div>I have to say I don&#39;t know much about DMM, =
but my understanding is that<br>
DMM is a bigger entity, of which TILER is only a small part, and DMM<br>
manages all memory accesses.<br>
<br>
Can there be other users for the DMM than DRM? I know there could be<br>
other users for the TILER, and I know you want to combine that with the<br>
DRM driver, but I&#39;m wondering about the other parts of DMM than the<br>
TILER.<br>
<br>
Somehow having a DMM driver inside omapdrm sounds strange.</blockquote><div=
><br></div><div>The DMM does indeed contain a number of entities. =A0Howeve=
r, the TILER portion is the only part that requires a driver. =A0All other =
register modifications (LISA map settings, EMIF, etc) are done statically i=
n the loader or u-boot and never changed again. =A0As such, DMM has become =
synonymous with TILER.</div>
<div><br></div><div>Regards,</div><div><br></div><div>Andy</div></div>

--f46d040123bdc66fe704ba9500b8--

--===============0325796738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0325796738==--
