From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up of
 supported ECC schemes
Date: Wed, 30 Oct 2013 21:30:24 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2D43E@DBDE04.ent.ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <20131024135258.GC9958@localhost>
 <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
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
To: Brian Norris <computersforpeace@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <Pawel.Moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Artem Bityutskiy <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, Avinash Philip <avinashphilipk@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi,
 Felipe" <balbi@ti.com>, Rob Herring <robherring2@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

> From: Brian Norris [mailto:computersforpeace@gmail.com]
[...]

> I agree with Ezequiel's thoughts, since the excessive amount of noise
> in this patch series has delayed it significantly. But at this point,
> I think it has stabilized; we have reviews from the DT folks (thanks
> guys; please comment if you have an official "ack" to give), and I
> think we've retained backwards compatibility properly; I've combed
> through it a few times over the months; we have a third-party tester;
> and at this point, I'm sure we're all sick of this.
> 
> So, without further delay: pushed all patches except path 8 to l2-mtd.git.
> 
Thanks much ..
I'll ensure that my next series are more logically aligned.


> Tony, you mentioned the DTS update in patch 8 going in via an ARM
> tree? This patch is not urgent, and it should probably wait until we
> know what release the rest of the series makes it into. This may
> depend on David Woodhouse's recommendation, but I'm not sure this
> series will have enough time baking in linux-next before entering
> mainline in 3.13 (the merge window is approaching).
> 
> Pekon/Ezequiel/others: please feel free to send any follow up cleanups
> for this driver. I'll take a look at what Ezequiel has already sent
> out and see if it's still applicable on top.
> 
Yes, I have other pending series, which I'll resend after rebasing on
this v11. But those are limited to internal NAND driver clean-up only
And do not touch DT or any other dependent driver.


with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
