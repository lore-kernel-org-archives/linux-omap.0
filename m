From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: dra7: Add CPSW and MDIO module nodes
 for dra7
Date: Fri, 12 Sep 2014 12:48:10 +0530
Message-ID: <54129E32.2080703@ti.com>
References: <1410356247-25925-1-git-send-email-mugunthanvnm@ti.com> <1410356247-25925-2-git-send-email-mugunthanvnm@ti.com> <5410573B.5010907@ti.com> <54114339.5070404@ti.com> <20140911212956.GC17692@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140911212956.GC17692-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lennart Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 12 September 2014 02:59 AM, Lennart Sorensen wrote:
> I have the mac but I don't want to use both ports on the 2 port switch.
> In fact in our case ethernet1 is a pru_eth interface.  Can a board dts
> override the alias for ethernet1 or is that a syntax error?  I don't
> think I tried that yet.

You can override it in board dts file

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
