From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] omap3: overo: Update LCD panel names
Date: Mon, 13 Jul 2015 23:48:11 -0700
Message-ID: <20150714064811.GB17550@atomide.com>
References: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
 <1434141446-11568-2-git-send-email-ashcharles@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434141446-11568-2-git-send-email-ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150612 13:39]:
> From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> For Gumstix Overo COMs, the u-boot bootloader typically passes an
> argument specifying the default display via the omapdss.def_disp
> parameter.  When a default display is specified, DSS2 tries to match
> this name with either the device tree label (e.g. label=dvi) or,
> failing this, the device tree alias (e.g. label=display0). Update the
> panel names for the 'lcd43' and 'lcd35' displays in the device tree
> such that they match the names passed by u-boot.

Applying this one into omap-for-v4.2/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
