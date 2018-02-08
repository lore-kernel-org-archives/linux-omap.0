From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] 8250_omap: Fix issues with throttling of 8250 port
Date: Thu, 8 Feb 2018 18:25:40 +0530
Message-ID: <20180208125542.15649-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series contains couple of fixes related to throttling of 8250 uart
port when tty buffer is under pressure.


Vignesh R (2):
  serial: 8250: Don't service RX FIFO if interrupts are disabled
  serial: 8250: 8250_omap: Fix throttling when DMA is enabled

 drivers/tty/serial/8250/8250_omap.c | 11 ++++++++++-
 drivers/tty/serial/8250/8250_port.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.16.1
