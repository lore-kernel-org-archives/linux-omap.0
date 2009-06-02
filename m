From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 09:08:28 +0300
Message-ID: <200906020908.28624.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A23CC97.1020209@tis.icnet.pl> <20090601210413.7678bf42.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28975 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbZFBGJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 02:09:16 -0400
In-Reply-To: <20090601210413.7678bf42.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

On Monday 01 June 2009 21:04:13 ext Jarkko Nikula wrote:
> On Mon, 01 Jun 2009 14:41:59 +0200
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > The original patch ported to linux-omap-2.6.27, the last omap relea=
se
> > with omap-alsa support, gives me a working sound driver on ams-delt=
a.
>
> Ok, good to know.
>
> > To make the original driver work stable, I had to patch the omap-al=
sa
> > framework to restore the original way that lack of dma chaining
> > problem had been solved in the original patch (see below), so maybe
> > there is a similiar issue in the currect ASoC McBSP framework?
>
> Is the older implementation working at commit
> d8376cc482b241701f7606c81ad578b90853e175 in linux-omap, i.e. last
> commit before their removal?
>
> What I see at quick look from the older implementation that it is doi=
ng
> somewhat similar way the DMA transfer and workaround for 1510 than
> current ASoC except that now the DMA parameters are not reprogrammed
> between the restarted transfers. I don't know if 1510 requires it?

Good question, but at least on DMA round should have been completed any=
ways if=20
this is the case...

>
> > My asoc based patch is also very generic and contains no more that
> > the same two ams_delta_latch2_write() hardware related operations,
> > called from inside snd_soc_dai_link.ops.startup() and
> > snd_soc_dai_link.ops.shutdown() callback functions:
>
> One thing worth to try would be try to use exactly same McBSP registe=
rs
> for omap_mcbsp_config in omap_mcbsp_dai_hw_params than used before fo=
r
> ams delta.

Good idea, I was about to suggest to print the McBSP config in the work=
ing old=20
alsa implementation, than print the non working from the ASoC version a=
nd see=20
the difference, but copying the working one to ASoC (hardwire for now) =
should=20
get it working.

>
> Sorry, have to cut my answer now here. I'll get back tomorrow.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
