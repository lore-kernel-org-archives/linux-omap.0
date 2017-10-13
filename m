From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 0/2] memory: Introduce ti-emif-sram driver
Date: Fri, 13 Oct 2017 15:59:13 -0500
Message-ID: <20171013205915.9652-1-d-gerlach@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
This is v5 of the series introduces a ti-emif-sram driver to be used on
am335x and am437x. The previous version of this 
series can be found here [1].

The only change to this version is to greatly simplify the makefile rules
used to generate the emif-asm-offsets header to fix some build issues
caught by the kbuild robot. The file has been renamed as ti-emif-asm-offsets.h
and is also now placed under include/generated so that it is handled along
with the other generated headers.

The macros were left inside the "ti_emif_offsets" inline function in the
ti-emif-sram header as they are also needed by the sleep33xx and sleep43xx
from the "code (seen here [2]), and describing the build depency on the
generated ti-emif-asm-offsets.h file got messy. Just including the macros in
the asm-offsets file generated for the arch/arm/mach-omap2 was the cleanest
way I could come up with, otherwise ensuring that ti-emif-asm-offsets.h is
generated before sleep33/43xx.S gets built was problematic. Of course,
I am open to a better idea if someone has one.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [3].

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg607959.html
[2] https://www.spinics.net/lists/arm-kernel/msg595934.html
[3] https://github.com/dgerlach/linux-pm/tree/upstream/v4.14/amx3-suspend-v5

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  18 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |  13 +
 drivers/memory/emif-asm-offsets.c                  |  22 ++
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 339 +++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 ++++++++++++++++++++
 include/linux/ti-emif-sram.h                       | 144 +++++++++
 8 files changed, 896 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.13.4
