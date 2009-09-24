From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCHv1 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Thu, 24 Sep 2009 15:56:58 +0530 (IST)
Message-ID: <65049.192.168.10.89.1253788018.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi All,

Resubmitting, After modifying patch series as per Tony's comments.

The Following series of patch adds support for OMAP3430-HIGH SPEED UART Controller.

[PATCHv1 1/3] - Adds support for omap-serial driver also includes header, Kconfig and Makefile.
                [ Patch v1- Removed SERIAL_OMAP_UARTx_RXDMA_BUFSIZE and
                 SERIAL_OMAP_UARTx_RXDMA_BUFSIZE from Kconfig, incorporated into platform data.]

[PATCHv1 2/3] - Adds platform data support for omap-serial driver.
                [ Patch v1- Incorporated rx bufsize and rx timoeout values and avoided using config
                option. ]

[PATCHv1 3/3] - Adds omap-serial driver support in omap_3430sdp_defconfig.
                [ No Changes ]

-- 
Regards,
Govindraj.R


