From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 22:29:37 +0300
Message-ID: <20080825192935.GA14939@frodo>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com> <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com> <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33114 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbYHYT36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 15:29:58 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 25, 2008 at 12:19:16PM -0700, Steve Sakoman wrote:
> Here's the crash output (alsa debugging is enabled in the kernel):

Can you apply the following patch just to make it easier to pinpoint
from where the BUG is coming from ?

diff --git a/include/sound/core.h b/include/sound/core.h
index 558b962..d2edf98 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -400,7 +400,7 @@ void snd_verbose_printd(const char *file, int line, const char *format, ...)
 } while (0)
 
 #define snd_BUG() do {                         \
-       snd_printk(KERN_ERR "BUG?\n");          \
+       snd_printk(KERN_ERR "%s %d: BUG?\n", __func__, __LINE__);       \
        dump_stack();                           \
 } while (0)

-- 
balbi
