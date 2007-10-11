From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/12] musb_hdrc: Add more sysfs notify events
Date: Thu, 11 Oct 2007 10:05:15 -0700
Message-ID: <11921223272557-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223262203-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Notify on all musb_stage0_irq events. For musb_stage2_irq events,
add notify on suspend. Do not notify on SOF.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3093bda..f7dc22c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -652,11 +652,11 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 				DBG(1, "Unhandled BUS RESET as %s\n",
 					otg_state_string(musb));
 			}
-			schedule_work(&musb->irq_work);
 		}
 
 		handled = IRQ_HANDLED;
 	}
+	schedule_work(&musb->irq_work);
 
 	return handled;
 }
@@ -811,6 +811,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
 			musb->is_active = 0;
 			break;
 		}
+		schedule_work(&musb->irq_work);
 	}
 
 
-- 
1.5.2.5
