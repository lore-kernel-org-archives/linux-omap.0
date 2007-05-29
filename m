From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 3/11] Add OMAP3 support
Date: Tue, 29 May 2007 10:30:38 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF102B@dlee13.ent.ti.com>
References: <1180437386.17658.0.camel@amit-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1180437386.17658.0.camel@amit-laptop>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: amit.kucheria@nokia.com
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Amit,

>> + machine-$(CONFIG_ARCH_OMAP3)		:=3D omap2
>                                             ^^^^^
>Surely you mean omap3 here?
>

We are using mach-omap2 directory for omap3, so omap2 is correct.

If we give omap3, then we need to create or have a mach-omap3 directory.

Here is what happens when I change this to omap3.

	scripts/Makefile.build:17: 	=
/data/omapsw_linux2/khasim/kimages/sktry/val_3430_GIT/arch/arm/mach-	=
omap3/Makefile: No such file or directory

Regards,
Khasim
