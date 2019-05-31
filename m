From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] Add HwSpinlock support for TI K3 SoCs
Date: Thu, 30 May 2019 21:13:18 -0500
Message-ID: <20190531021321.14025-1-s-anna@ti.com>
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
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Bjorn,

The following series adds the support for the HwSpinlock IP present
on the newer TI K3 AM65x and J721E SoCs. The first 2 patches are
related to the K3 support, and the last patch is a minor debug related
trace to see the number of locks registered on each SoC.

I will be posting the DT nodes once the binding is acked.

regards
Suman

Suman Anna (3):
  dt-bindings: hwlock: Update OMAP binding for TI K3 SoCs
  hwspinlock/omap: Add support for TI K3 SoCs
  hwspinlock/omap: Add a trace during probe

 .../bindings/hwlock/omap-hwspinlock.txt       | 25 +++++++++++++++----
 drivers/hwspinlock/Kconfig                    |  2 +-
 drivers/hwspinlock/omap_hwspinlock.c          |  4 +++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.21.0
