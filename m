From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] allow PTP 224.0.0.107 to be timestamped
Date: Fri,  6 Jul 2018 21:44:43 +0300
Message-ID: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

Allows packets with 224.0.0.107 mcas address for PTP packets to be timestamped.
Only for cpsw version > v1.15.

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw: use BIT macro
  net: ethernet: ti: cpsw: allow PTP 224.0.0.107 to be timestamped

 drivers/net/ethernet/ti/cpsw.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.17.1
