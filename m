From: Tony Lindgren <tony@atomide.com>
Subject: Re: Vibrations on Droid 4?
Date: Mon, 16 Jul 2018 00:59:26 -0700
Message-ID: <20180716075926.GU99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180715201729.GB19675@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180715 20:20]:
> Yep, so I have two patches that make the device appear, but vibrations
> still do not work for me.
> 
> a) any ideas how to debug that / get them to work?

Hmm no new ideas except I wonder if there is also some other
regression with the timer pdata not being passed properly now.

> b) do you want the patches anyway?

Yes for things that are obviously broken it makes sense.

Thanks,

Tony
