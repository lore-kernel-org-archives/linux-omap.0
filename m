From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Wed, 28 Sep 2016 08:49:30 +0200
Message-ID: <6004B143-F64B-4DA9-A054-3F2AB3FC2346@goldelico.com>
References: <cover.1474953969.git.hns@goldelico.com> <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com> <20160927194904.4im7ukktg5afjmki@atomide.com> <21B97601-328A-41DC-84EE-AA15A6977E98@goldelico.com> <20160928033703.erwozguik4rie3cn@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160928033703.erwozguik4rie3cn@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 28.09.2016 um 05:37 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [160927 13:11]:
>>> Am 27.09.2016 um 21:49 schrieb Tony Lindgren <tony@atomide.com>:
>>> How about this for defaults:
>>> 
>>> - heartbeat for led3
>>> - cpu0 for led4
>>> - cpu1 for led5
>> 
>> Good idea. Will try.
>> 
>> What I don't exactly know is if these gpios based on an I2C-expander
>> can handle cpu activity triggers or if they are locked up if this i2c
>> processing triggers another cpu activity...
> 
> Oh right, if the GPIOs are on the i2c bus

yes, they are all gpio9 which is the tca6424 on i2c5.

> it's probably not a good
> idea :) Or at least will be inaccurate if the bus can sleep.

I have tested a little by writing to /sys/class/leds/.../trigger.

If I make one LED trigger by "cpu0" it is always on and if I make
a second one triggered by "cpu1" the heartbeat becomes irregular.

So indeed this does not work.

BR,
Nikolaus
