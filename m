From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/5] omap3: dts: Add DTS for Gumstix TobiDuo expansion
 board
Date: Tue, 14 Jul 2015 04:01:46 -0700
Message-ID: <20150714110146.GP17550@atomide.com>
References: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
 <1434141446-11568-3-git-send-email-ashcharles@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434141446-11568-3-git-send-email-ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150612 13:39]:
> The Gumstix "Tobi-Duo" expansion board [1] can be used with either
> OMAP3 Overo or Overo Storm COMs.  It provides two NICs using LAN9221
> chips.
> It is necessary to duplicate the interface information for the
> second SMSC9221 chip as discussed [2].
> 
> [1] https://store.gumstix.com/index.php/products/241/
> [2] http://www.spinics.net/lists/linux-omap/msg115282.html

Applying patches 2 - 5 into omap-for-v4.3/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
