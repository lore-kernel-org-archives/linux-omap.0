From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/6] ARM: OMAP2+: dts: cm-t335: initial support
Date: Wed, 11 Nov 2015 09:50:49 -0800
Message-ID: <20151111175048.GG3218@atomide.com>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <56437BA1.8030807@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56437BA1.8030807-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [151111 09:32]:
> Gentle ping

Well the merge window is ongoing, and I'm not touching anything
except fixes until they are all out of the way. And after that
I'll start applying patches for v4.5 merge window, usually by
-rc2 except when things go wrong and we have regressions with
the mainline kernel like we did during v4.3-rc cycle.

So for fixes, it's always a good time to send them. The sooner
we have fixes out of the way after each merge window, the sooner
I'll start applying new features.

So for new features, between -rc1 and -rc4. We really want to
have all the new code sit in Linux next for a few weeks before
each merge window so in general I try to have things ready togo
by -rc5 for most part and by -rc6 latest.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
