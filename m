From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 failure in next-20170321
Date: Tue, 21 Mar 2017 08:38:52 -0700
Message-ID: <20170321153851.GA10760@atomide.com>
References: <20170321135708.GA22358@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321135708.GA22358@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [170321 06:59]:
> Hi!
> 
> Tony asked me to test linux-next from time to time. I did... today I
> moved from next-20170309 to next-20170321. Kernel boots and seems to
> work fine (including audio and X startup), but if I leave it sitting
> for a while RGB LED reverts from "system alive" to charging indication
> that was disabled before and system does not react to any input.
> 
> Any ideas?

Not much there I could see affecting this.. Try reverting commit
179125085bd4 ("ARM: OMAP3: Fix smartreflex platform data regression")?

Maybe smartreflex now attempts to do something but we're missing
or have wrong dts configuration for n900?

Regards,

Tony
