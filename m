From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers
Date: Mon, 13 Feb 2012 13:24:01 -0800
Message-ID: <20120213212401.GH1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Ben Hutchings <ben@decadent.org.uk>, Anders Kaseorg <andersk@ksplice.com>, Greg KH <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

It turns out that many compilers don't show section warnings on ARM
currently because handling for ARM_CALL relocs are missing from
modpost.c.

Based on commit c2e26114 ([ARM] 3205/1: Handle new EABI relocations when
loading kernel modules) it seems that R_ARM_PC24, R_ARM_CALL and
R_ARM_JUMP24 can be handled the same way.

As modpost.c includes elf.h, we need to also consider that at least
Debian libc6-dev is missing defines for both R_ARM_CALL and R_ARM_JUMP24
in /usr/include/elf.h.

So for now let's just use the numbers in modpost.c.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Anders Kaseorg <andersk@ksplice.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Anybody got better ideas for dealing with the missing elf.h
defines?

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1505,6 +1505,8 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 		              (elf->symtab_start + ELF_R_SYM(r->r_info));
 		break;
 	case R_ARM_PC24:
+	case 28:		/* R_ARM_CALL */
+	case 29:		/* R_ARM_JUMP24 */
 		/* From ARM ABI: ((S + A) | T) - P */
 		r->r_addend = (int)(long)(elf->hdr +
 		              sechdr->sh_offset +
