From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 4/4] Bluetooth: btwilink: drop superseded driver
Date: Mon, 21 Oct 2019 17:14:15 +0200
Message-ID: <AC376F8D-77F3-4497-94D1-FE25A5ED9337@holtmann.org>
References: <20191003134147.9458-1-sre@kernel.org>
 <20191003134147.9458-5-sre@kernel.org>
 <BC1F82AC-2988-4BC6-99EA-1C9F9289E582@holtmann.org>
 <20191020205901.56bafijk7cu3rpaj@earth.universe>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191020205901.56bafijk7cu3rpaj@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

>>> All users of this driver have been converted to the serdev based
>>> hci_ll driver. The unused driver can be safely dropped now.
>>> 
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>> drivers/bluetooth/Kconfig    |  11 --
>>> drivers/bluetooth/Makefile   |   1 -
>>> drivers/bluetooth/btwilink.c | 337 -----------------------------------
>>> 3 files changed, 349 deletions(-)
>>> delete mode 100644 drivers/bluetooth/btwilink.c
>> 
>> patch has been applied to bluetooth-next tree.
>> 
>> However what I really like to see is that you re-introduce a
>> btwilink driver that is purely serdev based and doesn’t rely on
>> any hci_uart/hci_ldisc code. A clean serdev only driver is that
>> best and easier to maintain long term.
> 
> So basically move the serdev implementation from hci_ll.c into its
> own driver and make hci_ll hci_uart based only? That effectively
> means, that we have two implementations of the protocol. I don't
> think this will improve maintainability, since then bugs needs to
> be fixed in two places? Note, that we have a couple of drivers
> with serdev+hci_uart by now:
> 
> for file in $(grep -l serdev drivers/bluetooth/hci_*c) ; grep -l hci_uart_register_proto "${file}"
> hci_bcm.c
> hci_h5.c
> hci_ldisc.c
> hci_ll.c
> hci_mrvl.c
> hci_qca.c

I would like to have something similar to btmtkuart.c which is a pure serdev driver that doesn’t depend on any hci_ldisc.c framework. If we have this, then we would just drop hci_ll.c from the kernel and focus on the serdev only version. As noted, there is no need for any other driver at that point since everything is probed anyway. Users will not even notice the difference.

Regards

Marcel
