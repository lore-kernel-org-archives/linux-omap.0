From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Interrupt issue in twl4030_keypad
Date: Mon, 12 Dec 2011 20:30:49 +0200
Message-ID: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

The short version is this: either we revert this patch[1], or we apply
this patch series[2], as well as its essential fixes[3].

The long version is this. There's a synchronization issue with the
current keypad driver and twl core; the irq is marked as handled even
though the thread that is supposed to handle it hasn't run yet, and
since it's clear-on-read, and it hasn't been read, it's detected
again, so they keypad driver receives two interrupt callbacks instead
of one, and in the second one reads nothing from the i2c register, so
a key release is assumed. This makes key-presses as simple as shift+a
impossible.

In other words, it's totally unreliable. This might not be isolated to
the keypard driver, but other "nested" interrupts from twl core that
started using request_threaded_irq prematurely (before it was
supported by the twl core). But at least I haven't tried those.

This patch was applied on 2.6.33, which means all versions before 3.2
are affected, including 3.1.

What do you think about fixing this on stable kernels?

Cheers.

[1] http://article.gmane.org/gmane.linux.kernel/932255
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/59958
[3] http://article.gmane.org/gmane.linux.ports.arm.omap/67333
-- 
Felipe Contreras
