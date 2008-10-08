From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030: Fix pwrirq by making sure the module is responding (Re: kernel oops for 3430sdp)
Date: Wed, 8 Oct 2008 11:05:17 -0700
Message-ID: <200810081105.17689.david-b@pacbell.net>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <20081007200921.GI8273@frodo> <20081008145517.GJ30831@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:46712 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754135AbYJHSGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 14:06:51 -0400
In-Reply-To: <20081008145517.GJ30831@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 08 October 2008, Tony Lindgren wrote:
> I suspect that twl is not yet initialized for pwrirq handling at this
> point. At least this patch seems to help, 

Did you verify that the value you read isn't 0xff?  Or does the
issue seem to be the mere attempt to read a register?

I have a hard time seeing the root cause be anything other than
problems in i2c-omap, since the timeouts appear at various other
places too.


> no idea on what registers 
> we should check though.. Anybody got ideas on what needs to be checked
> for pwrirq?

Well, there does seem to be an issue where the "pending IRQ" mechanism
can leave a PWRIRQ.PWRON interrupt pending sometimes.  If you see a
bunch of alarming-but-harmless boot messages like 

  TWL4030 module irq 373 is disabled but can't be masked!

before pwrirq registers, that seems to be the issue.  A debug hack I
applied (appended) reported that the mask (IMR) was 0xff but the IRQ
was still being raised ... when pwrirq registered itself, the stream
of those messages stopped.  (Or, when this hack dumped the status and
thus kicked in clear-on-read ...)

- Dave


=============================
---
 drivers/mfd/twl4030-core.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -574,6 +574,36 @@ static int twl4030_irq_thread(void *data
 			continue;
 		}
 
+		/* power irq before handler registered? */
+		if ((pih_isr & BIT(5)) && irq_desc[twl4030_irq_base + 5].depth) {
+			u8 buf[8];
+			int status;
+			int retries = 3;
+
+			while (retries--) {
+				status = twl4030_i2c_read(TWL4030_MODULE_INT,
+						buf, 0, sizeof buf);
+				if (status == 0) {
+					pr_crit("... PWR: "
+						"%02x.%02x/%02x.%02x "
+						"%02x; "
+						"%02x.%02x, "
+						"%02x "
+						"\n",
+						/* {ISR,IMR}{1,2} */
+						buf[0], buf[1], buf[2], buf[3],
+						/* SIH */
+						buf[4],
+						/* EDR */
+						buf[5], buf[6],
+						/* CTRL */
+						buf[7]);
+				} else
+					pr_crit("... read PWR --> %d\n",
+						status);
+			}
+		}
+
 		/* these handlers deal with the relevant SIH irq status */
 		local_irq_disable();
 		for (module_irq = twl4030_irq_base;

