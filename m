From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4+: PM: centralize static dependency mapping
 table
Date: Tue, 21 Oct 2014 15:22:27 -0500
Message-ID: <1413922949-22300-1-git-send-email-nm@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is a small step towards getting rid of static dependency logic
from mach-omap2. As part of this, we split the list of static dep
map from the function implementing it. This should eventually aid in
helping remove the tables from the kernel to the device tree at a
later point in time of cleanup.

Series based on v3.18-rc1 and could be a 3.19-rc1 material.

Nishanth Menon (2):
  ARM: OMAP4: PM: Only do static dependency configuration in
    omap4_init_static_deps
  ARM: OMAP4+: PM: Centralize static dependency mapping table

 arch/arm/mach-omap2/pm44xx.c |  146 +++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 80 deletions(-)

-- 
1.7.9.5
