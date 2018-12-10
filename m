From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce
 configuration
Date: Mon, 10 Dec 2018 06:32:29 -0800
Message-ID: <20181210143229.GY6707@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181209115648.GA23309@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209115648.GA23309@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Illia Smyrnov <illia.smyrnov@ti.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181209 11:56]:
> So, if I press key "." quickly on console in
> 4.18.0-rc4-88970-gf075a2c-dirty it starts repeating. I could reproduce
> it 3 times from tree tries. Then I decided to test your patch, and so
> I booted 4.20-rc5+ using kexec. Turns out, I can't reproduce that
> repeat there... I tried more than 10 times. But that's before your
> patch.
> 
> So -- bad news for you -- seems like someone -- maybe you -- already
> fixed this. (But that does not mean the patch is bad idea).

Hmm OK thanks for testing. For me it recently started happening before
this fix, often when logging in as root on the console using the keypad
where I'd start seeing roooooooot instead of root.

Regards,

Tony
