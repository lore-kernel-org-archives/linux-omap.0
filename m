From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 19/19] mtd: rawnand: Move JEDEC code to nand_jedec.c
Date: Fri, 7 Sep 2018 11:13:24 +0200
Message-ID: <20180907111324.691ba379@bbrezillon>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
 <20180906223851.6964-20-boris.brezillon@bootlin.com>
 <20180907084044.GA6361@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180907084044.GA6361@lenoch>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Alexander Clouter <alex@digriz.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, B
List-Id: linux-omap@vger.kernel.org

On Fri, 7 Sep 2018 10:40:44 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hi Boris,
> 
> this patchseries is really amazing clean up. Thank you!

I'm glad I'm not the only one to find it useful :-).

> 
> On Fri, Sep 07, 2018 at 12:38:51AM +0200, Boris Brezillon wrote:
> > This moves ONFI related code to nand_onfi.c and ONFI related
> > struct/macros to include/linux/mtd/onfi.h.  
> 
> Seems above commit log comes from previous patch.

Oops, will fix that.

Thanks,

Boris
