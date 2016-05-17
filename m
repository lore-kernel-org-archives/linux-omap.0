From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Tue, 17 May 2016 16:16:01 -0500
Message-ID: <20160517211541.GA30701@uda0271908>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463014396-4095-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wed, May 11, 2016 at 05:53:01PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Here's the whole series reposted with a bunch of additional changes.
> It seems to now properly work with with multiple phy cable status
> events, and should work for Ivaylo on n900 too.
> 
> Please re-review and re-test.

While trying to test this patch set, I just found that commit 56f487c (PM
/ Runtime: Update last_busy in rpm_resume) breaks dsps glue (TI am335x
device). Do you have an am335x board with has otg port on it to take a
look at this problem? The only board I know of which has an otg port is
TI am335x GP evm.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
