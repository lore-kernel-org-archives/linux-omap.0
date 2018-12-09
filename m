From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: poweroff does not work? calls
Date: Sun, 9 Dec 2018 08:46:50 -0800
Message-ID: <20181209164650.GX6707@atomide.com>
References: <20181209121318.GA24478@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209121318.GA24478@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181209 12:13]:
> Hi!
> 
> Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> affected. It is bad, because when your battery is low, you get into
> reboot loop and discharge it furher, which batteries do not like.
> 
> Any ideas, or at least idea how to debug this?

Hmm can you check if this is happening with usb unloaded or
unbind? I suspect ohci or musb..

Regards,

Tony
