From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 2/8] ARM: etm: Don't limit tracing to only non-secure code.
Date: Mon, 14 Feb 2011 22:11:10 -0800
Message-ID: <1297750276-12475-2-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shishkin <virtuoso@slind.org>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On some systems kernel code is considered secure, and this code
already limits tracing to the kernel text segment which results
in no trace data.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 arch/arm/kernel/etm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index d4ec368..6e15c48 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -55,7 +55,7 @@ static inline bool trace_isrunning(struct tracectx *t=
)
 static int etm_setup_address_range(struct tracectx *t, int n,
 		unsigned long start, unsigned long end, int exclude, int data)
 {
-	u32 flags =3D ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
+	u32 flags =3D ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_IGNSECURITY |
 		    ETMAAT_NOVALCMP;
=20
 	if (n < 1 || n > t->ncmppairs)
--=20
1.7.3.1
