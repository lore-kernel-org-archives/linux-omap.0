From: Tony Lindgren <tony@atomide.com>
Subject: New underflow of regulator enable count warnings in v5.0-rc1
Date: Tue, 29 Jan 2019 08:48:13 -0800
Message-ID: <20190129164813.GA5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers") started showing new warnings with v5.0-rc cycle:

regulator-dummy: Underflow of regulator enable count

I'm seeing this at least with my pwm-vibra test case:

# rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
input: pwm-vibrator as /devices/platform/vibrator/input/input4
regulator-dummy: Underflow of regulator enable count
Upload rumble effect... id=0
regulator-dummy: Underflow of regulator enable count

Are these bogus warnings for dummy regulator or do we have
real unpaired regulator calls or somewhere?

Regards,

Tony
