From: Afzal Mohammed <afzal.mohd.ma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: AM4372: Reorder the rtc compatible string
Date: Thu, 6 Aug 2015 19:03:06 +0530
Message-ID: <20150806133306.GA5484@afzalpc>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com>
 <1438771792-12604-2-git-send-email-j-keerthy@ti.com>
 <20150805153148.GB12328@saruman.tx.rr.com>
 <55C230E9.9010309@ti.com>
 <20150805161445.GF12328@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150805161445.GF12328-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Aug 05, 2015 at 11:14:45AM -0500, Felipe Balbi wrote:

> for them. Sure, it wasn't documented, but that's a problem of commit
> 73456012734b80442b33916406cfd13bf1b73acb (ARM: dts: AM4372: add few
> nodes) which, essentially, added that compatible flag without
> documenting it.

It was required to be done that way that time, probably author didn't
want to be loyal to the king than the king himself ;), see,

1. http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191206.html
2. http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg89473.html

Regards
Afzal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
