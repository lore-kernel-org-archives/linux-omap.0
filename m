From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for
 OMAP DMIC
Date: Wed, 23 Nov 2011 14:30:50 +0000
Message-ID: <20111123143049.GC20272@opensource.wolfsonmicro.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
 <1619032.uInsqOQfdX@barack>
 <20111123105806.GA21073@opensource.wolfsonmicro.com>
 <3755917.L7uBQxiu6F@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54079 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756060Ab1KWOaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:30:55 -0500
Content-Disposition: inline
In-Reply-To: <3755917.L7uBQxiu6F@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 23, 2011 at 04:00:23PM +0200, P=E9ter Ujfalusi wrote:
> On Wednesday 23 November 2011 10:58:07 Mark Brown wrote:

> > > We enable the clocks at dai_startup for the DMIC (and disable the=
m on
> > > dai_shutdown). We can not reparent while the clocks are enabled.
> > > This is the reason for this part.

> > That sounds like the enable is happening too early, then.

> This only enables the clock for the DMIC block, the clock for the ext=
ernal=20
> DMIC will start at trigger time (and stop as well).
> In order to access to DMIC registers we need clocks, and the clocks a=
re=20
> enabled for the duration we have capture stream open.
> I would think this is acceptable.

Meh, I guess.  It's hard to love code-wise.

> > If that's what you're doing then it seems like the machine drivers
> > should be use set_sysclk() (or perhaps even the clk API) to set up =
the
> > rate they're looking for from the visible clock rather than fiddlin=
g
> > about with magic divider values.  That way they can say exactly wha=
t
> > they want directly in terms of the result they're looking for.

> In OMAP4 DMIC the divider can not be chosen freely.
> The clock provided to the external microphones will depend on the sel=
ected=20
> DMIC_FCLK, and the divider.
> If I ask the machine driver to ask for specific speed for the externa=
l mic,=20
> the writer of the machine driver anyways have to look up the table fr=
om the=20
> TRM for the possible frequencies. So instead of providing magic divid=
er it has=20
> to provide magic speed.

Sure, but on the other hand it means that someone reading the machine
driver can tell what's going on without going back to the magic table
either.  Having the rates in the code makes the code more legible and
means that people can at least refer to the DMIC driver for a list of
supported rates rather than having to find the TRM.

I'd also guess that it's much more likely that people will remember
clock rates they can set than divider tables but perhaps that's just me=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
