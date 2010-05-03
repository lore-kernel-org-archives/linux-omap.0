From: Stephan Linz <linz@li-pro.net>
Subject: Re: OMAP 3530 LV-SOM support (was: Re: Patch format for submission?)
Date: Mon, 3 May 2010 16:13:51 +0200
Message-ID: <201005031613.52509.linz@li-pro.net>
References: <1250695463.10817.4.camel@blitz> <20100429171835.GB5644@gibbs.hungrycats.org> <j2q1f11a5491004301912xca6177d6y2bfd0b5fb68919df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:18341 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759055Ab0ECOOJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 10:14:09 -0400
In-Reply-To: <j2q1f11a5491004301912xca6177d6y2bfd0b5fb68919df@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ashwin Bihari <abihari@gmail.com>, Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>, Peter Barada <peterb@logicpd.com>

Am Samstag, 1. Mai 2010 04:12:19 schrieb Ashwin Bihari:
> On Thu, Apr 29, 2010 at 1:18 PM, Zygo Blaxell
>
> <vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
> > On Thu, Aug 20, 2009 at 06:02:06PM +0200, Stephan Linz wrote:
> >> Am Mittwoch, 19. August 2009 schrieb Peter Barada:
> >> > 1) Does anyone have a URL of the format patches should be in tha=
t are
> >> > submitted to the linux-omap list?
> >> >
> >> > I've got some patches to add base support for the Logic OMAP 35x=
 SOM
> >> > and Torpedo boards and I'd like to submit them in the right form=
at for
> >> > inclusion and push into mainline.
> >>
> >> Hi Peter,
> >>
> >> nice to see your announcement here at linux-omap. Today I've finis=
hed my
> >> own port for the Logic OMAP 35x SOM based on 2.6.31-rc1. We should=
 share
> >> our results befor submitting any patches to the list, or not?
> >
> > That's the last message I can find from either of you on this topic=
=2E
> > I'm in the process of rolling yet another patch set for 2.6.32.  Wa=
s any
> > further work done on this, or anything posted anywhere?
>
> Zygo,
>
> No, the LogicPD OMAP 35x support didn't quite make it out to the list=
,
> we are taking another crack at it shortly and would definitely love t=
o
> collaborate to get the changes out. We did create a Gitorious repo[1]=
,
> but that's sitting at 2.6.31-rc1 and we've internally got a newer
> version of the Kernel up to date..
>
> So we should definitely discuss off-list on how to pool our efforts t=
o
> get the support into the L-O tree..

Hi Zygo, Ashwin and Peter,

I was tied up with business and did no further work on my 2.6.31-rc1 fo=
r more=20
than six months. Since last week I've been working on a fresh port of m=
y own=20
patch set based on latest stable 2.6.32-omap1 (looks good except USB an=
d NOR=20
flash access).

Yes of course. We should discuss off-list on how to share our results. =
Last=20
summer I did create a new gitorious.org project for LogicPD omap boards=
 too:
http://gitorious.org/omap3logic (soory there is no content til now ;-))

We can use it as our stage, or not?

@Ashwin: Where is your Gitorious repo you tell about?


Regards,
Stephan


>
> Regards
> -- Ashwin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Viele Gr=FC=DFe,
Stephan Linz
_______________________________________________________________________=
_______
OpenDCC: http://www.li-pro.net/opendcc.phtml
PC/M: http://www.li-pro.net/pcm.phtml
CDK4AVR: http://cdk4avr.sourceforge.net/
CDK4NIOS: http://cdk4nios.sourceforge.net/
CDK4MSP: http://cdk4msp.sourceforge.net/
CPM4L: http://download.opensuse.org/repositories/home:/rexut:/CPM4L
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
