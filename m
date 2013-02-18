From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH 0/1] ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support
Date: Mon, 18 Feb 2013 14:41:56 +0200
Message-ID: <1361191317-24988-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch is a second attempt to add basic support of OMAP4 Blaze Tablet
software development platform - in this case using only Device Tree.

Additional information about this platform can be found here:
http://www.svtronics.com/omap?product_id=15

Ruslan Bilovol (1):
  ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support

 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/omap4-blazetablet.dts |  390 +++++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-blazetablet.dts

-- 
1.7.9.5
