From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: dts: add openpandora device support
Date: Fri, 20 Feb 2015 00:55:14 +0200
Message-ID: <CANOLnOOMLxDV6vQagfRaS7_YY6at91BbL0jPKkNQn-tYDnJEuw@mail.gmail.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424202743-26387-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 17, 2015 at 9:52 PM, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> changes from v1:
> - add new boards to makefile in patch 2,3 (don't add them
> in separate commit together), fix gpmc issues (reported by Tony Lindgren)
>
> - fix various issues reported by Grazvydas Ignotas
> (drop internal pullups from pinmux as external are in place,
> fix gpio buttons active state ...)
>
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).

All of these have been tested to be working, after adding missing
input flag for touchscreen. Well except musb, but I often have trouble
with that in mainline, probably not a problem with this dts.
Tested-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

And FWIW, the patches have been
Reviewed-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
