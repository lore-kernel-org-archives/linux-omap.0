From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH
 ecc-scheme via KConfig
Date: Wed, 23 Oct 2013 13:55:58 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2A130@DBDE04.ent.ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-11-git-send-email-pekon@ti.com>
 <20131023134450.GE2458@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131023134450.GE2458@localhost>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi,
 Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "computersforpeace@gmail.com" <computersforpeace@gmail.>
List-Id: linux-omap@vger.kernel.org

> From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> 
> Gupta,
> 
Please call me 'Pekon' :-)

[...]

> 
> I'm wondering how are you testing this in your SOC_AM33XX board (which
> is not ARCH_OMAP3). You probably have ARCH_OMAP3 always selected?
> 
Yes, omap2plus_defconfig is a super set..
arch/arm/configs/omap2plus_defconfig automatically enables ARCH_OMAP3.

> IMO, no need to depend on any ARCH_xxx, just make it depend on the
> driver 
> option itself, which already depends on ARCH_OMAP2PLUS (which is the
> bigger SoC family).
> 
> Care to send a one-patch fix for that, so this *independent* bug can be
> taken by Brian? Please add my Reported-by when you do so.
> 
Thanks. It's good to clean this dependency..
Yes, surely I'll send a independent patch with your reported-by..


with regards, pekon
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
