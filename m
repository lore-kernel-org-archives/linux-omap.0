From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3 0/5] OMAP Mailbox framework adoption & DT support
Date: Mon, 8 Sep 2014 19:52:26 -0700
Message-ID: <20140909025225.GI10785@atomide.com>
References: <1406680479-18446-1-git-send-email-s-anna@ti.com>
 <20140908232053.GS3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140908232053.GS3238-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [140908 16:21]:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140729 17:37]:
> > Hi,
> > 
> > This is an updated version of the OMAP Mailbox framework adoption &
> > DT support series, refreshed to work with the v9 version of the mailbox
> > framework [1] from Jassi Brar while also addressing some minor review
> > comments. Detailed changes are summarized below. Patches are based on
> > 3.16-rc2.
> 
> Sorry for the delay, just noticed that I'm supposed to queue
> these too. I'll queue these into omap-for-v3.18/mailbox against
> v3.17-rc1 and will probably also merge it into omap-for-v3.18/dt
> as well.

Actually this is not compiling and seems to probably miss
the dependencies from Jassi, so dropping the branch.

Anyways, since it seems you need to repost this again, please
repost the DT changes separately from the driver changes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
