From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 2/6] wl12xx: use frequency instead of enumerations for pdata clocks
Date: Mon, 16 Mar 2015 08:50:31 +0200
Message-ID: <87lhixphag.fsf@kamboji.qca.qualcomm.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
	<20150313150047.GI5264@atomide.com>
	<CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
	<3103538.jZ037SODdT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3103538.jZ037SODdT@wuerfel> (Arnd Bergmann's message of "Sun, 15
	Mar 2015 13:08:54 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-wireless@vger.kernel.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Luciano Coelho <luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> writes:

> On Sunday 15 March 2015 10:43:35 Eliad Peller wrote:
>> 
>> > The other option would be to have the whole series in a immutable
>> > branch against v3.0-rc1 that can be merged into both wirelss tree
>> > and omap tree.
>> >
>> i think that could be easier.
>> 
>> or maybe you can just take them all through the omap tree? the wlcore
>> tree is not under active development, so i don't expect conflicts
>> there.
>
> I'm fine with both these approaches.

I prefer these going through the omap tree. Like Eliad said,
drivers/net/wireless/ti does not get that many changes nowadays so the
chances of this patchset conflicting with something is very small.

-- 
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
