From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Date: Tue, 2 Aug 2016 11:41:46 +0530
Message-ID: <57A039A2.7030406@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <20160801152430.GM5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160801152430.GM5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Ungerer <gerg@uclinux.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-samsung-soc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kukjin Kim <kgene@kernel.org>, helgaas@kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, nsekhar@ti.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Simon Horman <horms@verge.net.au>, Krzysztof Halasa <khalasa@piap.pl>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shiraz
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 01 August 2016 08:54 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 01, 2016 at 04:42:29PM +0530, Kishon Vijay Abraham I wrote:
>> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
>> Fix it from getting redundantly selected in all
>> ARCH_MULTIPLATFORM based machines.
> 
> You're changing more than just platforms that are part of
> ARCH_MULTIPLATFORM.  Eg, ARCH_DOVE and ARCH_IXP4XX.  So, these will
> probably end up losing PCI support as a result of this change.

Okay. Initially assumed ARCH_MULTIPLATFORM will be set if MMU is set. But looks
like that's not true for some of the platforms. Will fix it and resend the series.

Thanks
Kishon
