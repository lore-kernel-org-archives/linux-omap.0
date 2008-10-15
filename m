From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 16:03:42 +0300
Message-ID: <87wsga9fip.fsf@trdhcp146196.ntc.nokia.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com>
	<alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
	<20081014172921.GJ20247@frodo>
	<200810141047.44803.david-b@pacbell.net>
	<20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
	<1224018598.4977.27.camel@localhost>
	<20081014212409.GL8150@atomide.com>
	<87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50291 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYJONBI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 09:01:08 -0400
In-Reply-To: <alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com> (ext Paul
	Walmsley's message of "Wed, 15 Oct 2008 01:49:16 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, r-woodruff2@ti.com

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello Jouni,
>
> On Wed, 15 Oct 2008, H=C3=B6gander Jouni wrote:
>
>> "ext Tony Lindgren" <tony@atomide.com> writes:
>>=20
>> > * Igor Stoppa <igor.stoppa@nokia.com> [081014 14:12]:
>> >> On Tue, 2008-10-14 at 13:59 -0700, ext Tony Lindgren wrote:
>> >>=20
>> >> > And that we can use same naming in the driver no matter which o=
map :)
>> >>=20
>> >> Wasn't that one of the main features of the clock FW, when it was
>> >> designed?
>> >
>> > Yes. But we adding separate ick and fck during omap2420 confused
>> > that.
>>=20
>> Why this was originally done? I mean we have possibility to autogate
>> interface clocks. AFAIK those could be just fine be enabled on boot =
and let
>> the hw to take care of them.
>
> Richard is really the best person to ask about this, so he's been add=
ed to=20
> the cc.  My current understanding is below.  Perhaps he can respond w=
ith=20
> more detail and correct any errors.
>
> In terms of original motivation, you might want to look at 34xx TRM=20
> 4.12.2.4.3.  I don't think this actually works in practice on OMAP3.
>
> Current practical use is different.  Autogating only takes effect dur=
ing=20
> sleep & wakeup transitions for the entire CORE_Lx clockdomain (34xx T=
RM=20
> 4.12.2.4.4).  So even if a module's functional clocks are disabled, t=
he=20
> PRCM won't autogate the module's interface clock until the entire COR=
E_Lx=20
> clockdomain transitions to inactive.  The theory here is that this wa=
stes=20
> power and that manually disabling the interface clock when the device=
 is=20
> known to be inactive should save some power.

L3 and L4 are anyway on when not in wfi, because of sleep/wkdep, so no
power save. This is the case at least with OMAP3 not sure about OMAP2.

>
> There also was some discussion last year that modules like GPTIMER ca=
n=20
> have their functional clocks enabled, but their interface clocks disa=
bled=20
> when register access is not needed.  Wakeups from the module are stil=
l=20
> sent asynchronously to the PRCM.  Again the motivation is to save pow=
er. =20
> I don't think the current code tries to do this.
>

In many modules there is also possibility to gate ick by HW when not
in wfi (see AUTOIDLE in SYCONFIG). I'm not sure about this but
extremely also fcks could be taken care by HW (see CLOCKACTIVITY in
SYSCONFIG).

>
> - Paul

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
