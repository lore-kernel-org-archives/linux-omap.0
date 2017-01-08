From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/4] net: ethernet: ti: cpsw: correct common res usage
Date: Sun,  8 Jan 2017 18:40:59 +0200
Message-ID: <1483893663-15673-1-git-send-email-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, mugunthanvnm@ti.com
Cc: linux-omap@vger.kernel.org, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

This series is intended to remove unneeded redundancies connected with
common resource usage function.

Based on net-next/master
Tested on am572x idk

Ivan Khoronzhuk (4):
  net: ethernet: ti: cpsw: remove dual check from common res usage
    function
  net: ethernet: ti: cpsw: don't disable interrupts in ndo_open
  net: ethernet: ti: cpsw: don't duplicate ndev_running
  net: ethernet: ti: cpsw: don't duplicate common res in rx handler

 drivers/net/ethernet/ti/cpsw.c | 57 ++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

-- 
2.7.4
