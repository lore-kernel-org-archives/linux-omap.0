From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Fri, 1 Apr 2016 12:06:27 -0700
Message-ID: <20160401190627.GO9329@atomide.com>
References: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
 <20160330211828.GE9329@atomide.com>
 <20160330213224.GH9329@atomide.com>
 <56FCC3FF.7080901@ti.com>
 <56FCEC61.5020400@ti.com>
 <20160331170017.GI9329@atomide.com>
 <20160401153606.GJ9329@atomide.com>
 <56FEC297.50102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56FEC297.50102-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [160401 11:50]:
> 
> Looks like a merge conflict to me, sys_32k_ck has gone under clockdomains
> for some reason. It should be under clocks.

Oh OK, I'll wait for an updated patch against v4.6-rc1 then.
Might be worth checking it applies cleanly against
omap-for-v4.6/fixes-rc1 too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
