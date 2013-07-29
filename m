From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/3] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
Date: Mon, 29 Jul 2013 12:03:00 -0500
Message-ID: <1375117383-19285-1-git-send-email-nm@ti.com>
References: <51F67D7D.9070003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F67D7D.9070003@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <benoit.cousson@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, dt list <devicetree@vger.kernel.org>, J Keerthy <j-keerthy@ti.com>, lkml <linux-kernel@vger.kernel.org>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Due to wrong older revision of documentation used as reference, we
seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
series is based power tree on production board 750-2628-XXX platform.
Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
supply hardware blocks at voltages that are out of specification.

Also available at:
based on v3.11-rc1 tag
http link: https://github.com/nmenon/linux-2.6-playground/commits/push/omap5-palmas-fixes-v2
git link: git://github.com/nmenon/linux-2.6-playground.git
branch: push/omap5-palmas-fixes-v2

Changes since V1:
 - squash of patches
 - picked up Ack from Keerthy
 - based on v3.11-rc3 tag

V1: http://marc.info/?t=137407980100008&r=1&w=2

Nishanth Menon (3):
  ARM: dts: omap5-uevm: document regulator signals used on the actual
    board
  ARM: dts: omap5-uevm: fix regulator configurations mandatory for SoC
  ARM: dts: omap5-uevm: update optional/unused regulator configurations

 arch/arm/boot/dts/omap5-uevm.dts |   78 ++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 29 deletions(-)

Regards,
Nishanth Menon
-- 
1.7.9.5
