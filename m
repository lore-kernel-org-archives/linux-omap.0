From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/3] pinctrl: add a driver for the OMAP pinmux
Date: Thu, 24 Nov 2011 11:09:18 +0100
Message-ID: <CACRpkdb5rbqEzFjuFw9iKeauaJ1rhGE7JnA34dnkogwh=DJ4Tw@mail.gmail.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
	<1321274409-24643-2-git-send-email-rnayak@ti.com>
	<20111114172312.GI31337@atomide.com> <4EC1EB9D.1000503@ti.com>
	<CACRpkdYuw+AfVtgfsbpkd=uvfWd8yE-n25EC0FDffhiGUS2MBw@mail.gmail.com>
	<CAJuYYwSgzkDed5-R=PaBR_F6ssj_EhxLDfCREXUA=UaynkgZyg@mail.gmail.com>
	<CACRpkdbBQoOU8hyew6tXth3Ohrg5_rN7M+tbVsYFcOjgq73aCw@mail.gmail.com>
	<CAJuYYwT_useS-8cH+qfDu5t7wh73yUuJAVXMjP5CXBS2VM3bag@mail.gmail.com>
	<CACRpkdax0GK=mNNao7FPc6JG0RwVywSEzGJPC_u73iJ_eOTgqQ@mail.gmail.com>
	<20111122175409.GE31337@atomide.com>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C5B3@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C5B3-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 23, 2011 at 1:28 AM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

> Describing the HW doesn't necessarily
> mean that each device needs to describe what pinmux pins it uses; one
> could quite easily have the pinmux describe what settings the various
> pins should have and which drivers will use those pins. That would map
> very well to the pinctrl subsystem's mapping table, and at least Tegra's
> existing pinmux tables, which are both just a big array of settings which
> end up getting provided to drivers.

That sounds true. It's also something that is cleanly cut out as a very
well defined and abstract piece of hardware information to live in the
device tree and which would be useful for any OS using DT.

I'd have to see the device trees and corresponding map bindings
before I understand it fully though.

Just my =800.01
Linus Walleij
