From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: ARM: AM335x: Reboot broken in 3.11
Date: Thu, 08 Aug 2013 14:50:18 +0100
Message-ID: <5203A21A.4060806@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Rebooting appears to have broken in 3.11 (at some point before rc1).

Here is the console output:-

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.11.0-rc1-00006-gf550793 (mpfj@mpfj-nanobone) (gcc version 4.6.3 (Buildroot 2013.02-dirty) ) #328 Thu Aug 8 14:36:16 BST 2013
...
Welcome to Buildroot
nanobone login: root
Password:
# reboot
#
[   23.867076] UBIFS: background thread "ubifs_bgt0_0" stops
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   25.924496] reboot: Restarting system

... and at this point the CPU seems to just freeze.

In 3v10, the board would reboot correctly back into uboot, etc.

I've also noticed that some of the output LEDs light up dim when the kernel
is booting on, and they come on full brightness at the reboot "freeze" point.
There are 4 LEDs affected and they are all connected to UART transmit pins.

Before I start bisecting, does anyone have any ideas ?

Cheers
Mark J.
