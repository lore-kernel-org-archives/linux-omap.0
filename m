From: "Anderson.Briglia@indt.org.br" <Anderson.Briglia@indt.org.br>
Subject: RE: [PATCH] MMC - CONFIG_HOTPLUG support
Date: Mon, 19 Dec 2005 09:52:59 -0300
Message-ID: <F26D8BDC5BC8014A909C6D45468F69EF022B680C@mzebe101.NOE.Nokia.com>
References: <43A31A75.7070500@indt.org.br>
	<20051216215823.GB1302@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: linux@arm.linux.org.uk
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> This patch improves the CONFIG_HOTPLUG support on the mmc core driver.
> Kernel version: 2.6.15-rc4-omap1

Please explain how this "improves" the support.

As we can see on usb core driver, there's a compiler directive that =
bypass the hotplug function if the CONFIG_HOTPLUG is not selected. I =
think I could add this "support" on the MMC driver. Just a optimization.
Please, correct me if I'm wrong.

BR,

Anderson Briglia
