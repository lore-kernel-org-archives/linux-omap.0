From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Thu, 10 Aug 2017 08:58:05 +0800
Message-ID: <20170810005804.GB31819@dragon>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Sekhar Nori <nsekhar@ti.com>, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mtd@lists.infradead.org, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, bcm-kernel-feedback-list@broadcom.com, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-omap@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-doc@vger.kernel.org, linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, Marek Vasut <marek.vasut@>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 04, 2017 at 05:29:10PM +0200, Boris Brezillon wrote:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>
...
>  arch/arm/mach-imx/mach-qong.c                   | 2 +-

Acked-by: Shawn Guo <shawnguo@kernel.org>
