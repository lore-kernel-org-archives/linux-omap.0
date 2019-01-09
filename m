From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] 8250_omap: use clk APIs to get fclk freqeuncy
Date: Wed, 9 Jan 2019 14:42:03 +0530
Message-ID: <20190109091206.25759-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series adds support obtain clk frequency of functional clk via
clocks phandle instead of hard coding it in DT as part of
clock-frequency DT parameter. This eliminates need to calculate
frequency offline and populate it.

Vignesh R (3):
  serial: 8250_omap: Drop check for of_node
  dt-bindings: serial: omap_serial: add clocks entry
  serial: 8250_omap: Use clk_get_rate() to obtain fclk frequency

 .../bindings/serial/omap_serial.txt           |  2 +
 drivers/tty/serial/8250/8250_omap.c           | 75 ++++++++++---------
 2 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.20.1
