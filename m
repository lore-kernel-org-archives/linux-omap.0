From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH 0/5] Rework of the TI81xx PRCM support
Date: Tue, 04 Oct 2011 03:31:11 -0600
Message-ID: <20111004092947.9657.16166.stgit@dusk>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hemant Pedanekar <hemantp@ti.com>
List-Id: linux-omap@vger.kernel.org

This is a rework of the TI81xx PRCM, powerdomain, and clockdomain code and
data.  Compile-tested only.

- Paul

---

Hemant Pedanekar (3):
      ARM: OMAP: TI81XX: prcm: Add module and register offsets
      ARM: OMAP: TI81xx: add powerdomain data
      ARM: OMAP: TI81xx: add clockdomain data

Paul Walmsley (2):
      ARM: OMAP: TI81xx: add powerdomain code
      ARM: OMAP: TI81xx: add clockdomain control code


 arch/arm/mach-omap2/Makefile                |    7 +
 arch/arm/mach-omap2/clockdomain.h           |    3 
 arch/arm/mach-omap2/clockdomain81xx.c       |   77 +++++++++
 arch/arm/mach-omap2/clockdomains81xx_data.c |  223 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                    |    2 
 arch/arm/mach-omap2/powerdomain.h           |    2 
 arch/arm/mach-omap2/powerdomain81xx.c       |   81 ++++++++++
 arch/arm/mach-omap2/powerdomain81xx_data.c  |   91 +++++++++++
 arch/arm/mach-omap2/prcm-regbits-81xx.h     |   23 +++
 arch/arm/mach-omap2/prcm814x.h              |   62 ++++++++
 arch/arm/mach-omap2/prcm816x.h              |  186 +++++++++++++++++++++++
 arch/arm/mach-omap2/prcm81xx.c              |  184 ++++++++++++++++++++++
 arch/arm/mach-omap2/prcm81xx.h              |  212 ++++++++++++++++++++++++++
 13 files changed, 1153 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain81xx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomain81xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomain81xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm-regbits-81xx.h
 create mode 100644 arch/arm/mach-omap2/prcm814x.h
 create mode 100644 arch/arm/mach-omap2/prcm816x.h
 create mode 100644 arch/arm/mach-omap2/prcm81xx.c
 create mode 100644 arch/arm/mach-omap2/prcm81xx.h

-- 
Signature
