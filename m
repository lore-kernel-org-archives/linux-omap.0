From: Tony Lindgren <tony@atomide.com>
Subject: Re: v4.18-rc2 on droid4: screen turns red
Date: Mon, 16 Jul 2018 23:26:08 -0700
Message-ID: <20180717062608.GY99251@atomide.com>
References: <20180630131812.GA549@amd>
 <20180711102655.GA6864@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711102655.GA6864@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180711 10:30]:
> Hi!
> 
> > After longer inactivity, attempt to wake up the screen results in
> > screen being completely red. Not too useful. I can still connect over
> > ssh.
> 
> Still there in -rc4 :-(. But happens only once in a few days for me...
> 
> When X is shut down, text console works ok.

FYI, I've been chasing an occasional hang with lapdock and it might
be related to the usb phy switching between usb and uart mode
spontaneously. And then the usb traffic can cause a sysrq trigger
potentially when the glitch happens. Not sure yet why it happens, it
might be related to lost cpcap interrupts still.

Anyways, so far looks like doing the following may have prevented
it. Well at least for about four days of uptime now:

# echo 0 > /proc/sys/kernel/sysrq

And no red screens here yet either. Care to check if this might
somehow also prevent your red screen issue?

Regards,

Tony
