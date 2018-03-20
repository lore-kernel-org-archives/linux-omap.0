From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Enable more droid 4 options in defconfig files
Date: Tue, 20 Mar 2018 07:16:17 -0700
Message-ID: <20180320141622.77989-1-tony@atomide.com>
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

We can now enable some more droid 4 related options to make it easier
to use and get things ready for distro kernels.

And I noticed kexec booting multi_v7_defconfig still needs --image-size,
so more work is needed there to debug that issue.

Regards,

Tony

Tony Lindgren (5):
  ARM: omap2plus_defconfig: Enable PWM_VIBRA
  ARM: omap2plus_defconfig: Add AUDIO_GRAPH_CARD
  ARM: omap2plus_defconfig: Enable MDM6600 USB PHY
  ARM: omap2plus_defconfig: Add UINPUT
  ARM: multi_v7_defconfig: Enable CPCAP related options mostly as
    loadable modules

 arch/arm/configs/multi_v7_defconfig  | 9 +++++++++
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 2 files changed, 14 insertions(+)

-- 
2.16.2
