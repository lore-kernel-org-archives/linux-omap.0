From: Frans Klaver <frans.klaver@xsens.com>
Subject: [RFC PATCHv2 0/4] omap-serial high-speed fixes/improvements
Date: Tue, 19 Aug 2014 14:14:44 +0200
Message-ID: <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Frans Klaver <fransklaver@gmail.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Here's version 2 of the patches that should improve the behavior of the omap
serial port at high baud and data rates.

Differences with regard to v1 are:
  - centralize baud_is_mode16's calculation
  - fix/unbreak an uninitialized variable in "use threaded interrupt handler"
  - read has-hw-flow-control property in of_get_uart_port_info

Frans Klaver (4):
  tty: omap-serial: pull out calculation from baud_is_mode16
  tty: omap-serial: prevent division by zero
  tty: omap-serial: use threaded interrupt handler
  tty: omap-serial: support setting of hardware flow control in dts

 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 drivers/tty/serial/omap-serial.c                   | 65 +++++++++++++++++-----
 2 files changed, 51 insertions(+), 15 deletions(-)

-- 
1.9.3

