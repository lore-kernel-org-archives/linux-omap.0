From: =?utf-8?q?tapio=20laxstr=C3=B6m?= <ext-tapio.laxstroem@nokia.com>
Subject: [PATCH 1/1] Fix function declaration.
Date: Fri,  4 Apr 2008 13:59:36 +0300
Message-ID: <1207306776-19509-2-git-send-email-ext-tapio.laxstroem@nokia.com>
References: <1207306776-19509-1-git-send-email-ext-tapio.laxstroem@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kusti.hard.ware.fi ([194.111.136.51]:36329 "EHLO
	kusti.hard.ware.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYDDLK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 07:10:26 -0400
In-Reply-To: <1207306776-19509-1-git-send-email-ext-tapio.laxstroem@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?utf-8?q?tapio=20laxstr=C3=B6m?= <ext-tapio.laxstroem@nokia.com>

Signed-off-by: tapio laxstr=C3=B6m <ext-tapio.laxstroem@nokia.com>
---
 arch/arm/mach-omap2/board-n800-audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-oma=
p2/board-n800-audio.c
index 75c4e4e..bebc4a5 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -316,7 +316,7 @@ void __init n800_audio_init(struct tsc2301_platform=
_data *tc)
=20
 #else
=20
-void __init n800_audio_init(void)
+void __init n800_audio_init(struct tsc2301_platform_data *tc)
 {
 }
=20
--=20
1.5.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
