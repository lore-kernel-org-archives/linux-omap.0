From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 linux-next 0/4] arm/arm64: configs: Convert all
 CONFIG_REMOTEPROC instances to y
Date: Fri, 20 Sep 2019 13:29:42 +0530
Message-ID: <20190920075946.13282-1-j-keerthy@ti.com>
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
To: arnd@arndb.de, nsekhar@ti.com, olof@lixom.net, t-kristo@ti.com, catalin.marinas@arm.com, will@kernel.org, tony@atomide.com
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 6334150e9 changes CONFIG_REMOTEPROC to a boolean config
option that inhibits all defconfigs marking CONFIG_REMOTEPROC as
a module in compiling the remoteproc and dependent config options.

So convert all the instances to built in.

Boot tested for omap2plus_defconfig for dra7/am4/am3.

Any quick testing on other boards welcome. 

Patches apply on top of linux-next branch

Changes in v2:

Cc the right lists.

Keerthy (4):
  arm: configs: omap2plus_defconfig: Change CONFIG_REMOTEPROC from m to
    y
  arm: configs: davinci_all_defconfig: Change CONFIG_REMOTEPROC  from m
    to y
  arm: configs: multi_v7_defconfig: Change CONFIG_REMOTEPROC  from m to
    y
  arm64: configs: defconfig: Change CONFIG_REMOTEPROC from m to y

 arch/arm/configs/davinci_all_defconfig | 2 +-
 arch/arm/configs/multi_v7_defconfig    | 2 +-
 arch/arm/configs/omap2plus_defconfig   | 2 +-
 arch/arm64/configs/defconfig           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1
