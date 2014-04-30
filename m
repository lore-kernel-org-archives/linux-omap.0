From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core
Date: Thu, 1 May 2014 00:17:39 +0200
Message-ID: <CAMuHMdVyQtJvC0G7i5DTYgW0eO3wuwqnvv0tSVA8BMzDkLG+zg@mail.gmail.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
	<4116377.A5MWbYX2Mh@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4116377.A5MWbYX2Mh@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Wed, Apr 30, 2014 at 11:29 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Thursday 24 April 2014 12:13:19 Geert Uytterhoeven wrote:
>> On SoCs like ARM/SH-mobile, gate clocks are available for modules, allowing
>> Runtime PM for a device controlled by a gate clock.
>>
>> On legacy shmobile kernels, this is handled by the PM runtime code in
>> drivers/sh/pm_runtime.c, which installs a clock notifier for the platform
>> bus, registering the "NULL" clock of each platform device with the PM core.
>> This approach is also used on davinci, keystone, and omap1.
>
> This requires the device to have the MSTP clock defined as the first clock in
> its DT node. I'm not against that, but the requirement should be clearly
> documented, and we need to check existing DT bindings to make sure they comply
> with that.

Being the first clock is only required for the "NULL" clock. And that
is only done
for legacy shmobile kernels, not for multi-platform.

In this patch series, the clock would be chosen based on the presence of the
CLK_RUNTIME_PM flag, to be set by the clock driver. I.e. DT is not involved
directly (for a change... why does everybody think the whole world revolves
 around DT these days ? :-)

> I'd like to also take this as an opportunity to discuss how we should name
> clocks in DT bindings for Renesas devices. Most devices have a single MSTP
> clock, in which case we don't specify a name. Other devices need several
> clocks. Names for the non-MSTP clocks will obviously be device-dependent, but
> how should the MSTP clock be called in that time ? Should it have an empty
> name (a "" string in DT) ? Should it have a standard name ? Maybe "fck" for
> "functional clock" ?

Empty names should not be used if there can be multiple clocks, right?

Grepping in arch/*/boot/dts/, "fck" seems to be popular (only) for TI SoCs.

Stadardizing across SoCs and architectures would be nice, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
