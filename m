From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 4/4] Bluetooth: btwilink: drop superseded driver
Date: Wed, 16 Oct 2019 21:15:03 +0200
Message-ID: <BC1F82AC-2988-4BC6-99EA-1C9F9289E582@holtmann.org>
References: <20191003134147.9458-1-sre@kernel.org>
 <20191003134147.9458-5-sre@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003134147.9458-5-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

> All users of this driver have been converted to the serdev based
> hci_ll driver. The unused driver can be safely dropped now.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> drivers/bluetooth/Kconfig    |  11 --
> drivers/bluetooth/Makefile   |   1 -
> drivers/bluetooth/btwilink.c | 337 -----------------------------------
> 3 files changed, 349 deletions(-)
> delete mode 100644 drivers/bluetooth/btwilink.c

patch has been applied to bluetooth-next tree.

However what I really like to see is that you re-introduce a btwilink driver that is purely serdev based and doesn’t rely on any hci_uart/hci_ldisc code. A clean serdev only driver is that best and easier to maintain long term.

Regards

Marcel
