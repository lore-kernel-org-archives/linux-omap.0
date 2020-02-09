From: Tony Lindgren <tony@atomide.com>
Subject: Re: 5.6-rc0.95: /dev/motmdm no longer there
Date: Sun, 9 Feb 2020 13:37:17 -0800
Message-ID: <20200209213717.GD64767@atomide.com>
References: <20200209213422.GA3009@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200209213422.GA3009@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200209 21:35]:
> Hi!
> 
> 5.6-rc0.95 -- based on:
> 
> commit fdfa3a6778b194974df77b384cc71eb2e503639a
> Merge: 291abfea4746 e0a514259378
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Feb 8 17:24:41 2020 -0800
> 
>     Merge tag 'scsi-misc' of
>     git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> 
> 
> /dev/motmdm* is not there for me. Unfortunately,
> drivers/mfd/motorola-mdm.c is not mainline, so I can't just try with
> the mainline....
> 
> Does it work for you?
> 
> I have ... rather a lot of warnings in dmesg :-(. /dev/ttyUSB4 works
> ok for me.
> 
> Can I somehow help get /dev/motmdmX upstream?

Heh yeah actually I'm cleaning up those patches right now :)

Meanwhile, try droid4-pending-v5.5 branch or pick the related
patches from there.

Regards,

Tony
