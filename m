From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Thu, 17 May 2007 12:53:44 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47F15ADB@dlee13.ent.ti.com>
References: <20070517174328.GB8556@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070517174328.GB8556@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi:

IMHO, using of SDRC_BASE as well as CTRL_BASE, PRCM_BASE etc.,
>> can lead to name collision, the names is not so unique as may
>> seem. I suggest using of OMAP_ prefix for these names.
>
>Good point. We could use OMAP_ prefix and in case of conflicts
>with omap1 defines, we could rename them to have OMAP1_ prefix.
>

When we started with 3430 developments we had similar issues. Our =
approach was,=20

OMAP3_prefix : If the Macro is defined and valid for 3430 only=20
OMAP2_prefix : If its valid only for OMAP2=20
	OMAP242x_prefix :	for 2420 specific
	OMAP243x_prefix : for 2430 specific=09
OMAP1_prefix : for all OMAP1 platforms, but we didn't change any, =
thinking it might break previous programs.
OMAP_prefix  : Generic for all OMAP platforms.

It's better if we follow some kind of standard and pass it as a review =
comment for any patches from now on.

Other alternative is to use Peripheral version in OMAP. Example:

OMAP1 has DMA version 3
OMAP2 has DMA version 4
OMAP3 has DMA version 4

So define a macro for DMA as=20

OMAP_DMA3_yyyyyy : for all OMAPs where DMA version 3 is used (like =
OMAPV1030, OMAP1710, OMAP1610, etc)

OMAP_DMA4_yyyyyy : for all OMAPs where DMA version 4 is used (like =
OMAP3430 2430 2420, etc).

Similar thing can be adopted for SPI, McBSP, I2C, and other peripherals =
of OMAP.

Regards,
Khasim
