From: Tony Lindgren <tony@atomide.com>
Subject: Re: nl80211 wlcore regression in next
Date: Mon, 22 Jul 2019 06:02:13 -0700
Message-ID: <20190722130213.GN5447@atomide.com>
References: <20190625073837.GG5447@atomide.com>
 <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
 <20190625080019.GH5447@atomide.com>
 <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Johannes Berg <johannes@sipsolutions.net> [190625 08:03]:
> On Tue, 2019-06-25 at 01:00 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
> > > On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
> > > > working in Linux next with commit 901bb9891855 ("nl80211: require and
> > > > validate vendor command policy"). Reverting the commit above makes it
> > > > work again.
> > > > 
> > > > It fails with the warning below, any ideas what goes wrong?
> > > 
> > > Oops. For some reason, I neglected to check the vendor command usage
> > > beyond hwsim.
> > > 
> > > The patch below should work?
> > 
> > Yeah thanks that fixes the issue for me:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks, I'll drop that into my tree and hopefully will remember to send
> it on soon.

Looks like this one crept back as the fix is missing from v5.3-rc1.

Forgot to include in the pull request?

Regards,

Tony
