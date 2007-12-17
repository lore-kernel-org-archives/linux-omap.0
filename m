From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Watchdog driver issue on OMAP3
Date: Mon, 17 Dec 2007 17:43:07 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302D6E609@dlee12.ent.ti.com>
References: <465714FA584D6D49BD2ADB26BB64FD0D01B9A8AB@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <465714FA584D6D49BD2ADB26BB64FD0D01B9A8AB@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Reddy, Teerth" <teerth@ti.com>, linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I am seeing this issue with the watchdog driver on=20
> OMAP3430,whenever the watchdog driver is closed the board=20
> should reboot but the board freezes after the watchdog=20
> timeout and I have to reboot the board manually to get the=20
> u-boot back.
>=20
> 	Is this an issue with the watchdog driver or is=20
> something else causing this?=20


I do recall that there has been some issues in the past where it has
been necessary to bypass some of the dplls for before a warm reset is
attempted. You may wish to try bypassing the dplls and then see if the
watchdog reset works.=20

For example, see the function omap2_prcm_arch_reset() in
arch/arm/mach-omap2/prcm.c.=20

Cheers
Jon
