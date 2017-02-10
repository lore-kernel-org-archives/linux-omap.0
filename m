From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Two wakeirq fixes
Date: Fri, 10 Feb 2017 14:24:59 -0800
Message-ID: <20170210222501.7948-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are two wakeirq fixes from Grygorii that have been pending for
a while.

Earlier before commit bed570307ed7 ("PM / wakeirq: Fix dedicated
wakeirq for drivers not using autosuspend") I did not see changes
with my test cases with these two changes, but now I have test cases
that get fixed with these two patches.

Regards,

Tony

Grygorii Strashko (2):
  PM / wakeirq: Enable dedicated wakeirq for suspend
  PM / wakeirq: Fix spurious wake-up events for dedicated wakeirqs

 drivers/base/power/wakeirq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.11.1
