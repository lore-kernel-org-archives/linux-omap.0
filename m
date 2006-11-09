From: "Hingkwan Huen" <hkh@cypress.com>
Subject: RE: patchs commits
Date: Thu, 9 Nov 2006 14:11:14 -0800
Message-ID: <002701c7044b$fbf4a100$818310ac@mis.cypress.com>
References: <20061109205157.GF16172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061109205157.GF16172@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'OMAP' <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

Do you know if the USB OHCI and Gadget are functional for the OMAP2420 =
H4?

Thanks,
kwan


-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]=20
Sent: Thursday, November 09, 2006 12:52 PM
To: Hingkwan Huen
Cc: 'Lu=EDs Vit=F3rio Cargnini'; 'OMAP'
Subject: Re: patchs commits

* Hingkwan Huen <hkh@cypress.com> [061109 22:44]:
> Hello Tony,
>=20
> How about OMAP2? Is there a way that I can find out the supported list =
of
> features for OMAP2, well, OMAP2420 H4 in particular?

The core stuff should be pretty well in sync for basic stuff such
as irq, timers, gpio, dma etc. But at least power management is still
not very functional. There should be some patches coming for PM, but
it may take a little while longer.

For the drivers, serial, NOR, i2c, and smc91x should work in mainline =
tree.=20
Framebuffer should work in linux-omap tree. MMC is probably currently
broken for Menelaus, but there are some patches coming for that.

Hope that helps,

Tony
