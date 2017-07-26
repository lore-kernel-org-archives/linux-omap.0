From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] USB: musb: fix external abort on suspend
Date: Wed, 26 Jul 2017 17:00:44 +0200
Message-ID: <20170726150046.22757-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This is a v2 of the fix for an external abort during suspend which I submitted
on Monday.

The commit message of patch 1/2 has only been slightly reworded, while
patch 2/2 is new.

Johan


Johan Hovold (2):
  USB: musb: fix external abort on suspend
  USB: musb: dsps: add explicit runtime resume at suspend

 drivers/usb/musb/musb_core.c | 18 ++++++++++--------
 drivers/usb/musb/musb_dsps.c | 13 +++++++++++--
 2 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.13.3
