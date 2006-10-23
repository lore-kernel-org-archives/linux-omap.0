From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Basic support for Palm Zire71
Date: Mon, 23 Oct 2006 16:22:25 +0300
Message-ID: <20061023132224.GE22577@atomide.com>
References: <200610202303.13569.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610202303.13569.marek.vasut@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marek =?utf-8?B?VmHFoXV0?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Marek Va=C5=A1ut <marek.vasut@gmail.com> [061021 00:04]:
> Hi,
>=20
> This patch adds basic support for Palm Zire71 PDA. LCD, backlight, MMC,
> touchscreen (using ads7846 driver) works. There is much more stuff supp=
orted=20
> now, but it=C2=B4s still dirty code which needs cleanup before sending =
here. If=20
> you are interested check www.hackndev.com . Patch is enclosed.

Can you please submit this in smaller patches? Something like this would
be nice:

1. Patch for board-*.c file
2. Fixes for clock framework
3. Fixes for serial init
4. Defconfig

Regards,

Tony
