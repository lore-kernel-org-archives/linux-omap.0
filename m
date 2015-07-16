From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7x-evm: fix incorrect compatibles
Date: Thu, 16 Jul 2015 19:03:34 +0530
Message-ID: <cover.1437053417.git.nsekhar@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Here non-critical compatible name fix
for DRA7x EVM for v4.3

Thanks,
Sekhar

Sekhar Nori (2):
  ARM: dts: dra7-evm: fix compatible name for pcf8575
  ARM: dts: dra72-evm: fix compatible name for pcf8575

 arch/arm/boot/dts/dra7-evm.dts  | 2 +-
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.4.4.408.g16da57c
