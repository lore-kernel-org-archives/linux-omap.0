From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB not workin in .27rc6, was: Re: OMAP support in mainline?
Date: Sat, 20 Sep 2008 00:47:48 +0300
Message-ID: <20080919214745.GB10156@frodo>
References: <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl> <20080918095537.GD28615@gandalf.research.nokia.com> <615FFFC3-999C-4DBD-A0FE-DCAA8BF18429@student.utwente.nl> <20080919212431.GP6617@frodo> <9CE3CC10-715B-49D9-B984-9F20671986F5@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47223 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbYISVsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 17:48:09 -0400
Content-Disposition: inline
In-Reply-To: <9CE3CC10-715B-49D9-B984-9F20671986F5@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Sep 19, 2008 at 11:34:13PM +0200, Koen Kooi wrote:
> If I boot up the .26 l-o kernel with mini-a attached, it works as
> expected.

What happens if you boot without anything attached then, after probe,
attach the mini-/micro-A ? The behavior you describe I recall having
working on one version of 3430sdp. Maybe the loader was keeping
twl4030-usb in a "working" state so we could get the id pin interrupt
before probing the device and after that, it doesn't work as it should.

Doesn't that mean otg is broken even in .26 l-o ? I'll only consider it
working when I attach the cable at any time and struct
xceiv->state switches to a_idle (at least). I don't even care about vbus
since it can (and most likely should) be exported to userland.

-- 
balbi
