From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/2] memory: Introduce ti-emif-sram driver
Date: Tue, 28 Mar 2017 15:55:09 -0500
Message-ID: <20170328205511.21166-1-d-gerlach@ti.com>
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
To: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
This series introduces a ti-emif-sram driver to be used on am335x and am437x.
These SoCs have low power modes that require that the PER power domain be shut
off. Because the EMIF (DDR Controller) resides within this power domain, it
will lose context during a suspend operation, so we must save it so we can
restore once we resume. However, we cannot execute this code from external
memory, as it is not available at this point, so the code must be executed late
in the suspend path and early in the resume path from SRAM.

Patch 2 includes several functions written in ARM ASM that can be relocated to
on-chip SRAM.  It also exports a table containing the absolute addresses of the
available PM functions so that other PM code also running from SRAM can branch
to them. It must also calculate virtual addresses for the suspend path, but
physical addresses for the resume path as the MMU is not active when the code
runs.

One thing that may not be immediately clear in the driver is that we can only
get read-only exectuable memory regions from the mmio-sram driver so we also
provide a second region to the driver that is read/write to be used for data
during execution. This is the reason two sram regions are mapped and so many
offsets must be provided to the code section.

In order for structs to co-exist in C and ASM, I went ahead and extended the
generic asm-offsets.c for ARM and added a single function call for this driver
that adds all the constants needed for the ASM code to get offsets into the
struct members. I managed to do it without many direct additions to the
asm-offsets file so I do not think it is too intrusive. This was the only way I
saw to do peaceful C and ASM data structure co-existence. Due to the
dependencies of all of the code on this I did not not split ARM vs drivers/
changes into separate patches because I think it would be more confusing that
way but if needed I think it can be done.

This code is required for low-power modes to work on AM335x and AM437x and a
forthcoming PM series for those platforms will depend on this series. After
both this and the PM series are reviewed I will send the necessary device tree
changes for both, but in the meantime all remaining patches for am335x and
am437x PM can be found here [1].

Regards,
Dave

[1] https://github.com/dgerlach/linux-pm/tree/upstream/v4.11/amx3-suspend-dev

Dave Gerlach (2):
  Documentation: dt: Update ti,emif bindings
  memory: ti-emif-sram: introduce relocatable suspend/resume handlers

 .../bindings/memory-controllers/ti/emif.txt        |  18 +-
 arch/arm/kernel/asm-offsets.c                      |   6 +
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   4 +
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 295 ++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 +++++++++++++++++++++
 include/linux/ti-emif-sram.h                       | 143 +++++++++
 8 files changed, 826 insertions(+), 1 deletion(-)
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h

-- 
2.11.0
