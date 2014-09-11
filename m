From: "Lennart Sorensen" <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: dra7: Add CPSW and MDIO module nodes
 for dra7
Date: Thu, 11 Sep 2014 08:22:19 -0400
Message-ID: <20140911122219.GD17690@csclub.uwaterloo.ca>
References: <1410356247-25925-1-git-send-email-mugunthanvnm@ti.com>
 <1410356247-25925-2-git-send-email-mugunthanvnm@ti.com>
 <20140911013811.GB17692@csclub.uwaterloo.ca>
 <541141E3.8030101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <541141E3.8030101-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 11, 2014 at 12:02:03PM +0530, Mugunthan V N wrote:
> slaves = <1>;

OK, works for me.

> overall disable takes care of this

Although once I enable cpsw I would need to leave the second port disabled
I suppose, although perhaps settings slaves to 1 would essentially
disable it.

> Will add disabled in next version.

-- 
Len Sorensen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
