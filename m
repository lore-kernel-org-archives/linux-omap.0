From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: early printk
Date: Thu, 18 Jan 2007 11:25:59 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50969C4F1@dlee02.ent.ti.com>
References: <20070118101336.18C6B80778@linux.omap.com><0AB0CB5257FF3C43A27E201CC8AADA8602D085A0@dnce02.ent.ti.com>
	<20070118170721.GB14425@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070118170721.GB14425@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Saint-Etienne, Eric" <e-saint-etienne@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Did someone already released an early-printk patch?
>=20
> Do you mean something other than low level printk?
>=20
> Low level printk should work, see CONFIG_DEBUG_LL and
> CONFIG_OMAP_LL_DEBUG_UART1 (or 2 or 3).

Seems like there has been some noise around some RT'ish changes + Timers
breaking some early printk's on the other lists.  I've not tried a build
recently to see if it affects OMAP at all.

Or it's a straight forward as CONFIG_DEBUG_LL.

Regards,
Richard W.
