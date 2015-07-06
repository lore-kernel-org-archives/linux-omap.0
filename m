From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Mon,  6 Jul 2015 22:26:13 +0200
Message-ID: <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Legacy bootloaders can pass additional information for kernel or legacy
userspace applications. When booting DT kernel then ATAGs structure is =
not
more visible after running kernel uncompress code. This patch stores fu=
ll
ATAGs structure into DT "/chosen/linux,atags" entry, so kernel can late=
r
reuse it and export via /proc/atags to userspace.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/co=
mpressed/atags_to_fdt.c
index e7e1cc9..ae93973 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -112,7 +112,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int to=
tal_space)
 	 * address and size for each bank */
 	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
 	int memcount =3D 0;
-	int ret, memsize;
+	int ret, memsize, atag_size;
=20
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
@@ -189,5 +189,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int to=
tal_space)
 			4 * memcount * memsize);
 	}
=20
+	/* include the terminating ATAG_NONE */
+	atag_size =3D (char *)atag - (char *)atag_list + sizeof(struct tag_he=
ader);
+	setprop(fdt, "/chosen", "linux,atags", atag_list, atag_size);
+
 	return fdt_pack(fdt);
 }
--=20
1.7.9.5
