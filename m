From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
Date: Tue, 25 Jun 2019 10:02:59 +0200
Message-ID: <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
References: <20190625073837.GG5447@atomide.com>
         <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
         <20190625080019.GH5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625080019.GH5447@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2019-06-25 at 01:00 -0700, Tony Lindgren wrote:
> Hi,
> 
> * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
> > On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > Looks like at least drivers/net/wireless/ti wlcore driver has stopped
> > > working in Linux next with commit 901bb9891855 ("nl80211: require and
> > > validate vendor command policy"). Reverting the commit above makes it
> > > work again.
> > > 
> > > It fails with the warning below, any ideas what goes wrong?
> > 
> > Oops. For some reason, I neglected to check the vendor command usage
> > beyond hwsim.
> > 
> > The patch below should work?
> 
> Yeah thanks that fixes the issue for me:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks, I'll drop that into my tree and hopefully will remember to send
it on soon.

johannes
