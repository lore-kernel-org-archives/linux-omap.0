From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/18] PRCM cleanup - remove prcm-regs.h
Date: Wed, 16 May 2007 18:11:32 -0600
Message-ID: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

These patches clean up PRCM register access in the OMAP2 tree.
Highlights:
 
- PRCM registers are divided into module-shared registers and global
  registers.  Module-shared registers can appear in multiple PRCM
  subsystems at identical address offsets, while global registers
  control system-wide PRCM functions and appear only once in PRCM space.

- PRCM registers are further separated into two categories, PRM
  (power/reset management) and CM (clock management) registers.  This
  is to prepare for OMAP3430 PRCM code -- PRM and CM registers share
  the same address space on 2420 and 2430, but exist in separate
  address spaces on 3430.

- Read/write functions are defined for each of the combinations above:
  prm_{read,write}_reg() for PRM global registers,
  prm_{read,write}_mod_reg() for PRM module-shared registers,
  cm_{read,write}_reg() for CM global registers,
  cm_{read,write}_mod_reg() for CM module-shared registers.   _reg()
  functions use a single (void __iomem *) to refer to global
  registers, and _mod_reg() functions use both a module offset and a
  register offset to refer to module-shared registers.  Almost all
  C-language PRCM register access in the mach-omap2/ directory is
  converted to use these functions.  If debugging is enabled, all
  PRM/CM register writes will be logged to the console.

- Symbolic constants are defined for PRCM register addresses.
  Registers that are shared between architectures are simply defined
  as-is, e.g., 'CM_CLKSEL', but registers that only exist on specific
  architectures have the architecture name prepended, e.g.,
  'OMAP2430_CM_ICLKEN3'.  This aids in identifying code that must be
  modified for cross-platform use.  Existing C code is converted to
  use these new constants.

- Symbolic constants are also defined for PRCM register bits, and
  existing C code that used 'magic numbers' for these bits is
  converted to use the symbolic defines.  This resulted in a major
  improvement in code readability.  As above, bits shared between
  architectures are labeled with only their 'base name,' but
  architecture-specific bits have the architecture name prepended,
  making it easy to identify code that will need to be changed for
  new architectures.

An overview of this patch series:

- Patches 1-9 add constants for PRCM modules, 24xx PRM and CM
  registers, 24xx PRM and CM register bits, and the register
  read/write functions.

- Patches 10-17 convert existing code to use the PRCM framework
  introduced in patches 1-9.

- Patch 18 removes prcm-regs.h.


Comments welcome.  

- Paul

-- 
