From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 0/3] Add pinmux DT nodes to CPSW for AM335x
Date: Fri, 7 Jun 2013 17:02:51 +0530
Message-ID: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
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
To: benoit.cousson@linaro.org
Cc: tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add pinmux DT nodes to CPSW for the following AM335x boards
* AM335x Beaglebone
* AM335x EVM
* AM335x EVMsk
default state contains the pinmux required for active mode and
sleep mode contains pinmux reset values for energy saving.

Mugunthan V N (3):
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM

 arch/arm/boot/dts/am335x-bone.dts  |   67 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   64 +++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   92 ++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

-- 
1.7.9.5
