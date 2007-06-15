From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 9 /12 ] Plat-omap files updating to support OMAP3
Date: Thu, 14 Jun 2007 22:27:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470123C687@dlee13.ent.ti.com>
References: <20070614115821.GH28804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070614115821.GH28804@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>This adds an extra artificial barrier to compiling in omap2 and omap3.
>Could you please change to be something like this:
>
>#ifdef CONFIG_ARCH_OMAP1
>...
>
>#elif defined(CONFIG_ARCH_OMAP2)
>
>#ifdef CONFIG_ARCH_OMAP24XX
>static struct omap_dm_timer omap24xx_dmtimers[] =3D {
>...
>};
>#endif
>
>#ifdef CONFIG_ARCH_OMAP34XX
>static struct omap34xx_dmtimers[] =3D {
>...
>};
>#endif
>#endif
>
>Then just put the right table in place during init like you did
>in io.c.
>

I am posting an RFC for this, please comment and let me know your views.

Regards,
Khasim
