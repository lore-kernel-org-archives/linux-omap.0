From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.19-rc1 on droid 4: screen not updating
Date: Mon, 27 Aug 2018 19:37:22 -0700
Message-ID: <20180828023722.GK7523@atomide.com>
References: <20180827105121.GA8283@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827105121.GA8283@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, tomi.valkeinen@ti.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, daniel@fooishbar.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180827 10:55]:
> Hi!
> 
> With Sebastian's patches, display works on Droid 4 in v4.18.

Hmm care to post your v4.18 patches somewhere too for people?
I'd have to look around for them since I've been using Linux
next for past few months.

Also, do you have v4.19-rc1 versions of your pending audio
patches somewhere? I'd like to play with voice calls again
now with my WIP pending n_gsm serdev patches..

> I had to do some manual merging, and I see kernel messages in
> v4.19-rc1, but they are frozen -- no updates.
> 
> a) does someone have it working?

I have had it working for few weeks since I'm following
Linux next. I just pushed Sebastian's patches I rebased
earlier today against v4.19-rc1 to [0][1].

> b) is there some way I can help to get it working in mainline? Droid 4
> is not exactly new, and this is painful point that makes it hard to
> use.

Well since Sebastian is busy according to [2], maybe try to update
Sebastian's mfd-ti-lmu backlight patches so they can get merged?
Please check with Sebastian, but that would cut down the pending
pile by quite a few patches.

Regards,

Tony

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-v4.19
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
[2] https://lists.freedesktop.org/archives/dri-devel/2018-August/186226.html
