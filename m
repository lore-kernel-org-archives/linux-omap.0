From: Ran Shalit <ranshalit@gmail.com>
Subject: suspend ethernet only , with WOL (wake on lan)
Date: Tue, 3 Mar 2015 08:21:41 +0200
Message-ID: <CAJ2oMhKJmrWN0WSzcoRW-AP+47qk-BefJLnkkdqe=Amgv=M5Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

I am using OMAP3530 with SMSC911X phy.

I see in smsc911 driver that it contain WOL (wake on lan) feature here:
http://lxr.free-electrons.com/source/drivers/net/ethernet/smsc/smsc911x.c

1. Is it that to enable WOL I just need ethtool (without configuring
anything in kernel) ?
https://wiki.archlinux.org/index.php/Wake-on-LAN

2. Is there a way to suspend ethernet only (without the full system suspend),
so that it will then WOL (wake on lan) ?

Thank you,
Ran
