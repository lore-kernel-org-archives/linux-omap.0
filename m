From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: seeing some junk characters on boot console with v4.9-rc1-3-g14155ca
Date: Tue, 18 Oct 2016 17:38:57 +0530
Message-ID: <7940c6b1-22df-90f9-4ef8-43b707db6f68@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi

I am seeing some junk characters on uart boot console on DRA72x platform
[1] and even on other TI platforms, did a bisect and found the commit
"761ed4a94582" broke it first.

By reverting below two commit, I don't see the issue logs [2].

761ed4a94582 "tty:serial_core: convert uart_close to use tty_port_close"
a5a2b13074fd "serial: core: fix potential NULL pointer dereference"

[1] - http://pastebin.ubuntu.com/23343431/
[2] - http://pastebin.ubuntu.com/23343435/

Regards
Mugunthan V N
