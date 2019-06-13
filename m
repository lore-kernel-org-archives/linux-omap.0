From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/4] ti-sysc dts changes for v5.3
Date: Thu, 13 Jun 2019 00:10:53 -0700
Message-ID: <pull-1560399818-512977@atomide.com-4>
References: <pull-1560399818-512977@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1560399818-512977@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit b6a53c4c872ab6870eb455d10a6f7ff0d99b1b1f:

  bus: ti-sysc: Detect uarts also on omap34xx (2019-05-28 05:19:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/ti-sysc-dt-signed

for you to fetch changes up to 22a7fc15cf1e742884fdc11a236fcd755225b4f0:

  ARM: dts: Drop legacy custom hwmods property for omap4 mmc (2019-05-28 05:19:17 -0700)

----------------------------------------------------------------
ti-sysc dts changes for v5.3

We can now drop the custom dts property "ti,hwmods" for drivers that
have the ti-sysc interconnect target module configured in dts.

Let's start with a minimal changes to omap4 uart and mmc. We use
omap4 as the starting point as it has runtime PM implemented and all
the omap variants after that are based on it with similar clkctrl
clock for the modules. More devices will be updated later on as they
get tested.

Note that these changes are based on the related ti-sysc driver
changes.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: dts: Drop legacy custom hwmods property for omap4 uart
      ARM: dts: Drop legacy custom hwmods property for omap4 mmc

 arch/arm/boot/dts/omap4-l4.dtsi | 9 ---------
 1 file changed, 9 deletions(-)
