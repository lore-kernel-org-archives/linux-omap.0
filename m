From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 01/18] ARM: am57xx: cl-som-am57x: dts: add basic
 module support
Date: Tue, 1 Dec 2015 09:03:01 -0800
Message-ID: <20151201170301.GU23396@atomide.com>
References: <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il>
 <1448893551-676-1-git-send-email-lifshitz@compulab.co.il>
 <20151130215415.GE23396@atomide.com>
 <565DC9CC.1070000@compulab.co.il>
 <20151201164317.GS23396@atomide.com>
 <565DCF34.8070001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565DCF34.8070001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [151201 08:48]:
> On 12/01/2015 10:43 AM, Tony Lindgren wrote:
> > * Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [151201 08:26]:
> >>
> >> It might looks the same set of regulators for multiple boards,
> >> but it is not. Each board may apply its own regulators usage scheme, and
> >> this is our case (as compared to am57xx-beagle-x15.dts).
> >>
> >> For the best of my knowledge, it used to be in a common *.dtsi file (at
> >> least in early OMAP5 DT support in TI kernel tree), but then I found that
> >> PMIC registration had been moved to the boards DT files.
> > 
> > Have you actually looked at how much of the implementation is same across
> > the omap5 boards? My guess is that a whole lot is same.. See for example
> > omap5-board-common.dtsi.
> 
> Unfortunately with DRA7 / AM57xx:
> at least 2 different PMICs -> DRA74/DRA72 evms.
> even across similar PMIC usage, different voltage rail usage accross
> evms: DRA74evm, x15/GPEVM, AM571x-IDK/AM572x-IDK -> they are not
> necessarily compatible.
> 
> Example: some of them have Ganged voltage rail, others dont - few others
> are mixed. if you are trying to get common regulator usage -> it is
> kinda pretty hard given the freedom board designers are being given by
> TI.. OMAP5 was more controlled in terms of what specific configuration
> the board designers had to follow. that is no longer the case for
> DRA7/AM57 platforms. just my 2 cents here.

OK thanks for checking. Best to wait a bit on that then until we have
more common patterns.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
