From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [RESEND] [PATCH v2 2/2] arm: boot: convert ATAG_REVISION to DT revision field
Date: Wed,  6 May 2015 10:49:02 +0200
Message-ID: <1430902142-17035-3-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38650 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbEFIt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 04:49:26 -0400
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

ATAG_REVISION is unsigned number and revision in DT is stored as hexade=
cimal
string value. It means that it will be correctly parsed by kernel.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/compressed/atags_to_fdt.c |   37 +++++++++++++++++++++++=
++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/co=
mpressed/atags_to_fdt.c
index 9448aa0..b23748e 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -97,6 +97,39 @@ static void merge_fdt_bootargs(void *fdt, const char=
 *fdt_cmdline)
 	setprop_string(fdt, "/chosen", "bootargs", cmdline);
 }
=20
+static void tohexstr(char * str, int size, unsigned int num)
+{
+	int len =3D 0;
+	int i, tmp;
+
+	if (size < 4) {
+		if (size > 0)
+			str[0] =3D 0;
+		return;
+	}
+
+	str[len++] =3D '0';
+	str[len++] =3D 'x';
+
+	while (len-1 < size && num) {
+		tmp =3D num % 16;
+		if (tmp >=3D 10)
+			tmp +=3D 'A';
+		else
+			tmp +=3D '0';
+		str[len++] =3D tmp;
+		num /=3D 16;
+	}
+
+	str[len] =3D 0;
+
+	for (i =3D 2; i < 2+(len-2)/2; ++i) {
+		tmp =3D str[i];
+		str[i] =3D str[len-i+1];
+		str[len-i+1] =3D tmp;
+	}
+}
+
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
@@ -171,6 +204,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int t=
otal_space)
 					cpu_to_fdt32(atag->u.mem.size);
 			}
=20
+		} else if (atag->hdr.tag =3D=3D ATAG_REVISION) {
+			char revision[11];
+			tohexstr(revision, sizeof(revision), atag->u.revision.rev);
+			setprop_string(fdt, "/", "revision", revision);
 		} else if (atag->hdr.tag =3D=3D ATAG_INITRD2) {
 			uint32_t initrd_start, initrd_size;
 			initrd_start =3D atag->u.initrd.start;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
