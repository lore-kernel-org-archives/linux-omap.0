From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Few omap2plus_defconfig updates
Date: Mon, 16 Mar 2015 13:00:00 -0700
Message-ID: <1426536003-7077-1-git-send-email-tony@atomide.com>
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

Here are few minor updates to add support for things as loadable
modules to omap2plus_defconfig for a few devices I noticed we
are not enabling by default.

Regards,

Tony


Tony Lindgren (3):
  ARM: omap2plus_defconfig: Enable leds-pwm
  ARM: omap2plus_defconfig: Update bluetooth options
  ARM: omap2plus_defconfig: Enable n900 modem as loadable modules

 arch/arm/configs/omap2plus_defconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.1.4
