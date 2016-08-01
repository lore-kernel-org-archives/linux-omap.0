From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Date: Mon, 1 Aug 2016 22:26:51 +0200
Message-ID: <20160801202651.GB13682@piout.net>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <579F6FAF.7010001@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <579F6FAF.7010001@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org, nsekhar@ti.com, Greg Ungerer <gerg@uclinux.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-samsung-soc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Kukjin Kim <kgene@kernel.org>, helgaas@kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Simon Horman <horms@verge.net.au>, Krzysztof Halasa <khalasa@piap.pl>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shiraz Hashim <shiraz.linux.kernel@g>
List-Id: linux-omap@vger.kernel.org

On 01/08/2016 at 17:50:07 +0200, Nicolas Ferre wrote :
> Le 01/08/2016 13:12, Kishon Vijay Abraham I a =E9crit :
> > *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> > Fix it from getting redundantly selected in all
> > ARCH_MULTIPLATFORM based machines.
> =

> And what happens if we select just one platform independently?
> =


That is fine for us because SOC_AT91RM9200 can only be selected once
ARCH_MULTIPLATFORM is selected anyway.

-- =

Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
