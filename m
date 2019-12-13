From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/2] ARM: dts: am33xx/am4372: Add cpuidle dt states
Date: Thu, 12 Dec 2019 22:17:23 -0600
Message-ID: <20191213041725.16831-1-d-gerlach@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This series adds DT idle states for TI am33xx and am4372 platforms.
The mpu_gate is added for both platforms which gates the MPU clock
to save power during idle. It depends on the driver series sent
here [1].

Regards,
Dave

[1] https://marc.info/?l=linux-kernel&m=157620644400324&w=2

Dave Gerlach (2):
  ARM: dts: am33xx: Add idle_states for cpuidle
  ARM: dts: am4372: Add idle_states for cpuidle

 arch/arm/boot/dts/am33xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/am4372.dtsi | 12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.20.1
