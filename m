From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB not workin in .27rc6, was: Re: OMAP support in mainline?
Date: Sat, 20 Sep 2008 04:12:15 +0300
Message-ID: <20080920011211.GC10156@frodo>
References: <87tzcgi1gv.fsf@nokia.com> <20080918095537.GD28615@gandalf.research.nokia.com> <615FFFC3-999C-4DBD-A0FE-DCAA8BF18429@student.utwente.nl> <200809191749.00327.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57153 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYITBMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 21:12:43 -0400
Content-Disposition: inline
In-Reply-To: <200809191749.00327.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, felipe.balbi@nokia.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Sep 19, 2008 at 05:49:00PM -0700, David Brownell wrote:
> On Friday 19 September 2008, Koen Kooi wrote:
> > Ok, another datapoint: client mode (tested on beagle by M=E5ns) and=
 host =A0
> > mode (tested on overo by Steve) work with a similar patch as above,=
 =A0
> > OTG mode is broken (tested on beagle and evm by me).
>=20
> one issue being that TWL4030 irqs don't cause the OTG state machine
> to change from the "Default_B" side to the "Default_A" side ... that
> is, ID sense isn't operational.

Exactly! I have some patches I wrote a few months ago regarding that.

Unfortunately I ran out of time to finish them due to other tasks havin=
g
a bigger priority.

I'll try to get back that work, since it's pretty necessary.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
