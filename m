From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v3 0/4] omap-serial high-speed fixes/improvements
Date: Mon, 15 Sep 2014 16:00:06 +0200
Message-ID: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's version 3 of my fixes for high speed usage of the omap serial driver.
Sebastian's 8250 based implementation doesn't seem to be quite there yet. As
long as that's the case, I'd like to go ahead with improving this series.

v2..v3
  - fix an undefined variable in "prevent division by zero"
  - use IRQ_ONESHOT for the threaded irq in "use threaded interrupt handler"

v1..v2
  - centralize baud_is_mode16's calculation
  - fix/unbreak an uninitialized variable in "use threaded interrupt handler"
  - read has-hw-flow-control property in of_get_uart_port_info

Frans Klaver (4):
  tty: omap-serial: pull out calculation from baud_is_mode16
  tty: omap-serial: prevent division by zero
  tty: omap-serial: use threaded interrupt handler
  tty: omap-serial: support setting of hardware flow control in dts

 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 drivers/tty/serial/omap-serial.c                   | 64 +++++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.1.0

