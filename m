From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 0/3] serial: 8250: fix locking/race/cleanup issues
Date: Fri, 31 Jul 2015 00:54:08 +0200
Message-ID: <87io912r5b.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.comtony@atomide.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch series addresses some locking, race condition, and cleanup
issues identified with the 8250 serial driver on omap boards.

John Ogness (3):
  serial: 8250: unlock port for uart_write_wakeup()
  serial: 8250: move rx_running out of the bitfield
  serial: 8250: omap: restore registers on shutdown

 drivers/tty/serial/8250/8250.h      |    2 +-
 drivers/tty/serial/8250/8250_core.c |    6 +++++-
 drivers/tty/serial/8250/8250_omap.c |   14 ++++++++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
1.7.10.4
