From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Thu, 18 May 2006 07:30:05 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A505B7DBDC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Our current internal tree one does the following in board_2430.c for
ether.


void sdp_reset (void)
{
#define LAN_RESET_REGISTER (H4_DEBUG_FPGA_VA_BASE+0x1c)
	int cnt =3D 20;

	__raw_writew(0x0, LAN_RESET_REGISTER);
	do {
		__raw_writew(0x1, LAN_RESET_REGISTER);
		udelay (100);
		if(cnt =3D=3D 0)
			goto sdp_reset_err_out;
		--cnt;
	} while (__raw_readw(LAN_RESET_REGISTER) !=3D 0x1);

	cnt =3D 20;

	do {
		__raw_writew(0x0, LAN_RESET_REGISTER);
		udelay (100);
		if(cnt =3D=3D 0)
			goto sdp_reset_err_out;
		--cnt;
	} while (__raw_readw(LAN_RESET_REGISTER) !=3D 0x0000);
	udelay (400);
 sdp_reset_err_out:
	return;
}

static int __init smc91x_init(void)
{
	sdp_reset();

	if ((omap_request_gpio(ETH_GPIO)) < 0) {
		printk("%s: unable to request GPIO for smc91x\n",=20
		       __FUNCTION__);
		return -1;
	} else {
		omap_set_gpio_direction(ETH_GPIO, OMAP24XX_DIR_INPUT);
		omap_set_gpio_edge_ctrl(ETH_GPIO, OMAP_GPIO_LEVEL_LOW);
	}
	return 0;
}

static struct resource smc91x_resources[] =3D {
	[0] =3D {
	       .start	=3D OMAP24xx_ETHR_BASE,	/* Physical */
	       .end	=3D OMAP24xx_ETHR_BASE + SZ_4K,
	       .flags	=3D IORESOURCE_MEM,
	       },
	[1] =3D {
	       .start	=3D INT_ETHER,
	       .end	=3D 0,
	       .flags	=3D IORESOURCE_IRQ,
	       },
};

static struct platform_device smc91x_device =3D {
	.name		=3D "smc91x",
	.id		=3D 0,
	.num_resources	=3D ARRAY_SIZE(smc91x_resources),
	.resource	=3D smc91x_resources,
};

-----Original Message-----
From: linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m
] On Behalf Of Komal Shah
Sent: Thursday, May 18, 2006 6:45 AM
To: linux-omap-open-source@linux.omap.com
Subject: [PATCH] ARM: OMAP: Add minimal OMAP2430 support

Tony/Richard,

* NFS is still not working. NETDEV Watchdog timeouts.
* Intel Starta flash gets detected - JFFS2 is not yet tested.
* platform_add_devices() is not working - Let me know, where I
am making mistake :)

Please review.
---

This patch adds minimal OMAP2430 support.
Based on 2.6.10 Linux kernel available on linux.omap.com from TI.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

--=20
http://www.fastmail.fm - A fast, anti-spam email service.
