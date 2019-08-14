From: Tony Lindgren <tony@atomide.com>
Subject: Regression in Linux next with show wakeup sources stats in sysfs
Date: Tue, 13 Aug 2019 23:38:03 -0700
Message-ID: <20190814063803.GY52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tri Vo <trong@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <swboyd@chromium.org>, Kalesh Singh <kaleshsingh@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
in sysfs") has caused a regression in Linux next where I can now get
some errors like this during the boot:

kobject_add_internal failed for wakeup10 (error: -2 parent: usb)

Any ideas why this might be happening? Maybe some deferred probe
related issue?

Regards,

Tony
