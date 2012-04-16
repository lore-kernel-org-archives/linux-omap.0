From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
Date: Mon, 16 Apr 2012 20:36:56 +0530
Message-ID: <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

In the error cases the clock cut is missed. This patch intends to fix the
same.

Cc: stable@vger.kernel.org
Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index fe099bb..10e80bb 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -319,6 +319,8 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 		if (ret < 0) {
 			serial_omap_enable_ier_thri(up);
+			pm_runtime_mark_last_busy(&up->pdev->dev);
+			pm_runtime_put_autosuspend(&up->pdev->dev);
 			return;
 		}
 	}
@@ -1029,8 +1031,10 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 
 	pm_runtime_get_sync(&up->pdev->dev);
 	status = serial_in(up, UART_LSR);
-	if (!(status & UART_LSR_DR))
+	if (!(status & UART_LSR_DR)) {
+		pm_runtime_put(&up->pdev->dev);
 		return NO_POLL_CHAR;
+	}
 
 	status = serial_in(up, UART_RX);
 	pm_runtime_put(&up->pdev->dev);
-- 
1.7.4.1

