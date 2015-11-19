From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 03/27] mtd: nand: update examples in the documentation to
 use mtd_to_nand()
Date: Thu, 19 Nov 2015 11:22:07 -0800
Message-ID: <20151119192207.GG64635@google.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 16, 2015 at 02:37:36PM +0100, Boris Brezillon wrote:
> mtd_to_nand() has been introduced to hide accesses to mtd->priv.
> All NAND controller drivers should use it instead of directly accessing
> the ->priv field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Pushed to l2-mtd.git
