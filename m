From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/4]  Rework hw-assisted flow control
Date: Sun, 25 Jan 2015 14:44:50 -0500
Message-ID: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:65203 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbbAYTpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 14:45:06 -0500
Received: by mail-qg0-f44.google.com with SMTP id l89so4414588qgf.3
        for <linux-omap@vger.kernel.org>; Sun, 25 Jan 2015 11:45:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Hi Greg,

This patch series re-implements hw-assisted flow control support,
(aka autoRTS, autoCTS and auto XON/XOFF) in the serial core.
Out-of-tree driver maintainers please note this changes the UART
driver interface for flow control steering.

This series separates mode handling from the capabilities flags.
UPF_HARD_FLOW and UPF_SOFT_FLOW continue to indicate the hardware
is capable of hw-assisted flow control; in addition, UPF_HARD_FLOW
is split into separate capabilities (UPF_AUTO_CTS and UPF_AUTO_RTS)
should the driver require the distinction.

However, the serial core only checks UPF_SOFT_FLOW (to determine
if the UART driver is capable of auto XON/XOFF flow control and
thus needs its set_termios() method called).

Flow control steering in the serial core is now determined by
the uart_port::status field, and the newly introduced
UPSTAT_AUTOCTS, UPSTAT_AUTORTS and UPSTAT_AUTOXOFF for
autoCTS tx flow control, autoRTS rx flow control and auto
IXOFF flow control respectively. [Core support for auto IXON did
not seem necessary, as core intervention does not seem required --
please let me know if that's not the case.]

Typically, the driver should set or reset these flags in their
set_termios() method (in the port lock critical section, if
port lock is used), depending on the hardware capabilities and
requirement.

All drivers which enable hardware autoCTS mode MUST set UPSTAT_AUTOCTS
to prevent the serial core from inadvertently disabling tx. In this
mode, hw_stopped = 0 and uart_handle_cts_change() perform no action
(other than bumping the cts stat for diagnostic purposes).

For hardware which does not automatically disable autoRTS mode
when RTS is lowered or otherwise desires to implement
throttle()/unthrottle() methods, the driver MUST set UPSTAT_AUTORTS.
In this mode, the uart driver throttle()/unthrottle() methods
are called, rather than lowering RTS via set_mctrl().

UPSTAT_AUTORTS _must not_ be set for drivers which do not implement
throttle()/unthrottle() methods; in this case, set_mctrl() is still used
to control the RTS pin.

Even for drivers using UPSTAT_AUTORTS, the driver is still responsible
for properly implementing RTS handling in set_mctrl(), regardless of
current termios settings or hardware mode. That is, if the hardware
is capable of driving the RTS pin, the driver's set_mctrl() method
must lower RTS if !TIOCM_RTS. If that requires disabling autoRTS mode,
then that shall be done. The serial core and userspace must be able to
manually flow control with RTS.

When handling set_mctrl(), the driver may check the uart_port::status
UPSTAT_AUTORTS bit to determine if it set autoRTS mode at set_termios(),
and thus whether to restore its autoRTS mode when RTS is raised. In other
words, the driver does not need to set/check its own private state.

All drivers which enable hardware auto IXOFF flow control mode
MUST set UPSTAT_AUTOXOFF. As with UPSTAT_AUTORTS, throttle()/unthrottle()
methods are required. When this mode is set, the core will _not_ send
START/STOP, and expects the driver/hardware to do so.

This patch series converts in-tree drivers to this 'new' interface.

The last patch rips out a private interface hack being used by a
bluetooth host controller driver to tickle RTS for device wakeup;
this is no longer required now that the offending in-tree driver,
omap-serial, properly drives RTS in autoRTS mode.

Regards,

Peter Hurley (4):
  serial: core: Rework hw-assisted flow control support
  serial: 8250_omap: Use UPSTAT_AUTORTS for RTS handling
  serial: omap: Fix RTS handling
  tty: Remove external interface for tty_set_termios()

 drivers/bluetooth/hci_ath.c         | 15 +-------
 drivers/tty/serial/8250/8250_omap.c | 23 ++++++-----
 drivers/tty/serial/omap-serial.c    | 29 +++++++++-----
 drivers/tty/serial/serial_core.c    | 76 ++++++++++++++-----------------------
 drivers/tty/tty_ioctl.c             |  3 +-
 include/linux/serial_core.h         | 21 ++++++++--
 include/linux/tty.h                 |  1 -
 7 files changed, 83 insertions(+), 85 deletions(-)

-- 
2.2.2

