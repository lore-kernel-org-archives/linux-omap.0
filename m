From: Merlijn Wajer <merlijn@wizzup.org>
Subject: [RFC PATCH 0/1] power: supply: bq27xxx: Call power_supply_changed on status change
Date: Wed, 28 Feb 2018 02:04:43 +0100
Message-ID: <20180228010452.1713-1-merlijn@wizzup.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: merlijn@wizzup.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt.ranostay@konsulko.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

It seems that bq27xxx_battery_update does not call power_supply_changed when the
charging status changes, and instead only when the capacity changes.

This can cause considerable delays in reporting charging status changes to
userspace. This patch turns the battery status reading function into one that
returns the value directly (as other *_read functions), adds the status to the
cache, uses the cache when reporting the values and finally will trigger
power_supply_changed when the charging status changes.

There is still a noticable delay in detecting charger status, but that seems to
have a different cause.

Cheers,
Merlijn
