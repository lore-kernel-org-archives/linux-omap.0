From: Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH v2 0/1] usb: musb: fix vbus_show
Date: Tue, 27 Feb 2018 23:27:38 +0100
Message-ID: <20180227222740.2150-1-merlijn@wizzup.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, merlijn@wizzup.org, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This fixes reading vbus status in musb.

v2 places the pm_runtime_{get,put}_sync calls outside of the spinlocks, because
pm_runtime_{get,put}_sync would otherwise (sometimes, depending on the platform)
cause deadlocks.
Hopefully this fixes the deadlock issue that Bin Liu ran into. I've tested this
patch on my Nokia N900 and it works for me.

Cheers,
Merlijn
