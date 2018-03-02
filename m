From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Update multi_v7_defconfig for USB OTG and PHYs
Date: Fri,  2 Mar 2018 09:32:16 -0800
Message-ID: <20180302173219.46112-1-tony@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Looks like we don't have USB OTG, MUSB and PHYs configured and this
prevents me from running my USB and PM tests with multi_v7_defconfig
out of the box. Let's enable those options as loadable modules.

Regards,

Tony


Tony Lindgren (3):
  ARM: multi_v7_defconfig: Enable OTG and MUSB as loadable modules
  ARM: multi_v7_defconfig: Enable various USB PHYs found on omap
    variants
  ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module

 arch/arm/configs/multi_v7_defconfig | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.16.2
