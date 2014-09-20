From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Fri, 19 Sep 2014 21:07:06 -0500 (CDT)
Message-ID: <alpine.DEB.2.10.1409192100380.23826@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com> <1411067086-16613-4-git-send-email-nm@ti.com> <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna> <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos> <20140919191649.GQ14505@atomide.com> <alpine.DEB.2.10.1409191233590.4213@nanos> <20140919195738.GR14505@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140919195738.GR14505-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Sep 2014, Tony Lindgren wrote:
> * Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> [140919 12:47]:
> > Why on earth are you wanting tasklets in there? That's just silly,
> > really.
> 
> Lack of a framework on driver side to cope with this in a generic
> way? :p

So instead of creating such a thing we rather have a completely ass
backward workaround which spreads itself all over the tree?

You SoC folks really need a quarterly sanity check.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
