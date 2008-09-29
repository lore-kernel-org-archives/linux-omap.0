From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 3/5] [RFC] ALSA ASOC Adds DSP DAI format support for platform driver
Date: Mon, 29 Sep 2008 15:20:12 +0530
Message-ID: <dfeb90390809290250x7c9d3aafh232fbcbe8ae77d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:39610 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYI2JuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:50:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2165677rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 02:50:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Enables DSP DAI format for mcbsp in omap platform driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3a4cc4b..1c024aa 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -292,6 +292,12 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 0-bit data delay */
+		regs->rcr2	|= RDATDLY(0);
+		regs->xcr2	|= XDATDLY(0);
+		break;
+
 	default:
 		/* Unsupported data format */
 		return -EINVAL;
-- 
1.5.3.4
