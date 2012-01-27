From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there
 is CAM domain ACTIVE
Date: Fri, 27 Jan 2012 16:03:49 +0200
Message-ID: <20120127140349.GE15297@valkosipuli.localdomain>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
 <CAORVsuWYvvZ_kp=9OTYMjDBibbsOSuBmkUU+u9mb_hKpL80d1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-68.nebula.fi ([83.145.220.68]:52380 "EHLO
	smtp-68.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab2A0ODy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 09:03:54 -0500
Content-Disposition: inline
In-Reply-To: <CAORVsuWYvvZ_kp=9OTYMjDBibbsOSuBmkUU+u9mb_hKpL80d1Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, khilman@ti.com

Hi Jean,

Thanks for you quick reply.

On Fri, Jan 27, 2012 at 12:06:37PM +0100, Jean Pihet wrote:
> Hi,
>=20
> On Fri, Jan 27, 2012 at 11:00 AM, Sakari Ailus <sakari.ailus@iki.fi> =
wrote:
> > MPU and CORE should stay awake if there is CAM domain ACTIVE. This =
is
> > because that module doesn't have wake-up capability.
> >
> > The original patch was written by Jouni H=F6gander in 2008 and this=
 is the
> > last part left of it which is not in upstream yet.
> >
> > I wonder if the approach taken in the patch is valid these days;
> > nevertheless it seems to do the job...
> The code in the function omap3_enter_idle_bm from
> arch/arm/mach-omap2/cpuidle34xx.c is doing exactly the same thing: it
> is choosing the cpuidle safe_state if the CAM power domain is active.
>=20
> Please note that this only works if CPU_IDLE is selected, which is
> needed to reach any decent low power mode.

I didn't have CONFIG_CPU_IDLE selected --- it works if I enable it. But
still it should work even if it's disabled I guess.

Kind regards,

--=20
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
