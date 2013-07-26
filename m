From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: [PATCH] mfd: input: arm: dts: doc: ti_am335x: typo fix (coordiante -> coordinate)
Date: Fri, 26 Jul 2013 22:37:09 +0100
Message-ID: <1374874630-25457-1-git-send-email-zubair.lutfullah@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

 
Small typo fix. Received ack from mfd already.
Awaiting acks from all the rest.

As Lee from mfd stated, we can remove these during staging now.
or we'll have to leave typos as is later on.

Zubair Lutfullah (1):
  mfd: input: arm: dts: doc: ti_am335x: typo fixes (coordiante ->
    coordinate)

 .../bindings/input/touchscreen/ti-tsc-adc.txt      |    4 ++--
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |    2 +-
 drivers/mfd/ti_am335x_tscadc.c                     |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.9.5

