From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 09:21:47 +0300
Message-ID: <87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com>
	<alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
	<20081014172921.GJ20247@frodo>
	<200810141047.44803.david-b@pacbell.net>
	<20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
	<1224018598.4977.27.camel@localhost>
	<20081014212409.GL8150@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27140 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYJOGTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 02:19:08 -0400
In-Reply-To: <20081014212409.GL8150@atomide.com> (ext Tony Lindgren's message
	of "Tue, 14 Oct 2008 14:24:10 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

"ext Tony Lindgren" <tony@atomide.com> writes:

> * Igor Stoppa <igor.stoppa@nokia.com> [081014 14:12]:
>> On Tue, 2008-10-14 at 13:59 -0700, ext Tony Lindgren wrote:
>>=20
>> > And that we can use same naming in the driver no matter which omap=
 :)
>>=20
>> Wasn't that one of the main features of the clock FW, when it was
>> designed?
>
> Yes. But we adding separate ick and fck during omap2420 confused
> that.

Why this was originally done? I mean we have possibility to autogate
interface clocks. AFAIK those could be just fine be enabled on boot and=
 let
the hw to take care of them.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
