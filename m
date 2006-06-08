From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Couple boot failures on H4-2420 and their reasons.
Date: Thu, 8 Jun 2006 14:19:09 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506198C31@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I just pulled and tried the H4 and it wouldn't boot given the defconfig.
A little probing shows the following:

	- omap's mmc_set_ios is hanging in the MMC_POWER_UP loop.

	- irlm_do_discovery()'s structure entry irlmp_cb.hints is not
half word aligned and the compiler is trying to do a ldrh from there.
It appears the hints structure is supposed to be a union of uchar[2] and
a u16 but it fails to align to the right structure size (GCC 3.4.1
anyway).  I've force aligned the structure, but I don' t know if that is
right or now.

Regards,
Richard W.
