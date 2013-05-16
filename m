From: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <v-stehle@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: select SCU
Date: Thu, 16 May 2013 16:29:07 +0200
Message-ID: <5194ED33.7050502@ti.com>
References: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net> <51938169.4060109@ti.com> <5194DAC5.9080203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5194DAC5.9080203@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

So the exact commit breaking OMAP5 link for me is:

  883a106 ARM: default machine descriptor for multiplatform

The breakage seems to be a side effect of not selecting ARCH_VEXPRESS
any more, which causes HAVE_ARM_SCU to not be selected any more, too,
when compiling only for OMAP5. IMHO this only reveals a deeper issue.

Probably the ideal fix would be to remove all references to the scu_
functions for OMAP5, but those seem to exist in files and functions,
common to OMAP4 and 5 (sleep44xx.S, omap-smp.c).

How would you deal with that, please?

Best regards,

V.
