From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/5] wlcore: sdio: Populate config firmware data
Date: Wed, 14 Sep 2016 10:13:06 -0700
Message-ID: <20160914171303.5h4ktdwfrsfnduf6@atomide.com>
References: <20160913215043.29454-1-tony@atomide.com>
 <20160913215043.29454-4-tony@atomide.com>
 <87intycsta.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87intycsta.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> [160914 10:09]:
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> 
> > Configure the config firmware names and make it available
> > in platform data.
> >
> > Let's also fix the order of the struct wilink_family_data
> > while at it.
> >
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/net/wireless/ti/wlcore/spi.c | 42 ++++++++++++++++++++----------------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> I think the title should be:
> 
> wlcore: spi: Populate config firmware data
> 
> I can fix that during commit.

Oops sorry shift+Insert caused typo :)

Tony
