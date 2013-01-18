From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power
 functions
Date: Fri, 18 Jan 2013 11:11:46 +0100
Message-ID: <50F91FE2.3020402@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com> <50F7C4A7.5060202@ti.com> <20130117093417.GH10814@arwen.pp.htv.fi> <50F7CA82.4050509@ti.com> <20130117100510.GI10814@arwen.pp.htv.fi> <20130117100919.GJ10814@arwen.pp.htv.fi> <1358418917.6252.31.camel@cumari.coelho.fi> <50F7D535.6030205@ti.com> <20130117173131.GL14149@atomide.com> <1358445456.6252.64.camel@cumari.coelho.fi> <20130117231608.GP14149@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130117231608.GP14149@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Luciano Coelho <coelho@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 01/18/2013 12:16 AM, Tony Lindgren wrote:
> Well we are planning to drop the non-DT support for omap4 as soon as =
it's
> usable with DT.

Exactly, but right now we do have legacy and legacy should work in orde=
r to
help for example Luca to make the final push which allows us to move to=
 DT
only for OMAP4.

> For omap4 we are only carrying SDP and panda support to
> make this transition easier. The only bindings missing AFAIK are wl12=
xx and
> USB.
>
> If we add this, then it implies we're somehow supporting it, which is=
 not
> the way to go IMHO as we need to get rid of these platform callbacks =
instead.

IMHO we should keep these boards working as long as we have the legacy =
board
support for them.

So what is the policy now regarding to 'old' legacy but still used OMAP=
4 board
files? I think we should still maintain them, but the effort to get rid=
 of
them should be the highest priority.

--=20
P=E9ter
