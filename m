From: Tony Lindgren <tony@atomide.com>
Subject: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Mon, 7 Jan 2019 15:38:33 -0800
Message-ID: <20190107233833.GI5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
over to using hrtimers") caused a regression on at least
omap5-uevm where 8250 UART rx wake no longer works. I have not
noticed this happening on others so far.

The devices I've tested all are using 8250 with dedicated
wakeirqs configured for the rx pin. I can see the interrupt
increase on omap5-uevm after some one or more keypresses,
but then nothing. It seems that the uart just falls back
asleep right away or something.

Any ideas what might be going wrong?

Regards,

Tony
