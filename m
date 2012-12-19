From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add an entry for omap related .dts files
Date: Wed, 19 Dec 2012 12:34:14 +0000
Message-ID: <20121219123414.32B5E3E0AD7@localhost>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
 <20121214194452.9874.40037.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9102321059787430824=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121214194452.9874.40037.stgit@muffinssi.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============9102321059787430824==
Content-Type: text/plain

On Fri, 14 Dec 2012 11:44:52 -0800, Tony Lindgren <tony@atomide.com> wrote:
> All your omap .dts files are belong to us.
> 
> Benoît has been doing a good job picking up most of the
> omap .dts files so far. Let's make sure we both get
> cc:ed for the related patches.
> 
> The .dts patches need to be queued by us as separate
> patches from drivers and other code changes to avoid
> pointless merge conflists like we saw with v3.8
> networking changes.
> 
> Cc: Benoît Cousson <b-cousson@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bc485c..4927e80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5253,6 +5253,15 @@ F:	arch/arm/*omap*/
>  F:	drivers/i2c/busses/i2c-omap.c
>  F:	include/linux/i2c-omap.h
>  
> +OMAP DEVICE TREE SUPPORT
> +M:	Benoît Cousson <b-cousson@ti.com>
> +M:	Tony Lindgren <tony@atomide.com>
> +L:	linux-omap@vger.kernel.org
> +L:	devicetree-discuss@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm/boot/dts/*omap*
> +F:	arch/arm/boot/dts/*am3*
> +
>  OMAP CLOCK FRAMEWORK SUPPORT
>  M:	Paul Walmsley <paul@pwsan.com>
>  L:	linux-omap@vger.kernel.org
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.


--===============9102321059787430824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9102321059787430824==--
