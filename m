From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Date: Wed, 9 Aug 2017 14:41:03 -0700
Message-ID: <20170809214101.GG3934@atomide.com>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, Neil Armstrong <narmstrong@baylibre.com>, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, Sekhar Nori <nsekhar@ti.com>, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mtd@lists.infradead.org, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, bcm-kernel-feedback-list@broadcom.com, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-omap@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-doc@vger.kernel.org, linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, Marek Vasut <marek.vasut>
List-Id: linux-omap@vger.kernel.org

* Boris Brezillon <boris.brezillon@free-electrons.com> [170804 08:30]:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>
