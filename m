From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Wed, 23 Nov 2011 17:24:41 +0200
Message-ID: <2903628.kUHW0DbjnM@barack>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com> <3755917.L7uBQxiu6F@barack> <20111123143049.GC20272@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45592 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756485Ab1KWPYn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 10:24:43 -0500
Received: by mail-bw0-f47.google.com with SMTP id zs2so1647394bkb.6
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 07:24:42 -0800 (PST)
In-Reply-To: <20111123143049.GC20272@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Wednesday 23 November 2011 14:30:50 Mark Brown wrote:
> Meh, I guess.  It's hard to love code-wise.

So you would prefer me to enable the OMAP DMIC's clocks at pcm_trigger:=
start=20
time, and disable them on pcm_trigger:stop?
I have seen cases when the driver did not received the pcm_trigger:stop=
 prior=20
to pcm_close call, so in that case a safety check in dai_shutdown is ne=
eded to=20
be sure the dmic clocks are really disabled.
I would still prefer to keep the dmic clocks enabled for the duration t=
he=20
stream is open. On the other hand if I had it in pcm_trigger, I don't n=
eed to=20
play with the clocks when reparenting...

> > > If that's what you're doing then it seems like the machine driver=
s
> > > should be use set_sysclk() (or perhaps even the clk API) to set u=
p
> > > the
> > > rate they're looking for from the visible clock rather than fiddl=
ing
> > > about with magic divider values.  That way they can say exactly w=
hat
> > > they want directly in terms of the result they're looking for.
> >=20
> > In OMAP4 DMIC the divider can not be chosen freely.
> > The clock provided to the external microphones will depend on the
> > selected DMIC_FCLK, and the divider.
> > If I ask the machine driver to ask for specific speed for the exter=
nal
> > mic, the writer of the machine driver anyways have to look up the t=
able
> > from the TRM for the possible frequencies. So instead of providing
> > magic divider it has to provide magic speed.
>=20
> Sure, but on the other hand it means that someone reading the machine
> driver can tell what's going on without going back to the magic table
> either.  Having the rates in the code makes the code more legible and
> means that people can at least refer to the DMIC driver for a list of
> supported rates rather than having to find the TRM.
>=20
> I'd also guess that it's much more likely that people will remember
> clock rates they can set than divider tables but perhaps that's just =
me.

Sure, I will change the driver accordingly.

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
