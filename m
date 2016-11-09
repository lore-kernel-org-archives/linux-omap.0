From: Tony Lindgren <tony@atomide.com>
Subject: PM regression with LED changes in next-20161109
Date: Wed, 9 Nov 2016 12:23:02 -0700
Message-ID: <20161109192301.GS26979@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
the sysfs brightness attr for changes.") breaks runtime PM for me.

On my omap dm3730 based test system, idle power consumption is over 70
times higher now with this patch! It goes from about 6mW for the core
system to over 440mW during idle meaning there's some busy timer now
active.

Reverting this patch fixes the issue. Any ideas?

Regards,

Tony
