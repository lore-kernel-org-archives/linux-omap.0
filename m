From: Tomasz =?utf-8?Q?M=C5=82oduchowski?=
	<tomasz.mloduchowski@xlogic.pl>
Subject: Re: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Mon, 11 Apr 2011 14:17:58 +0200 (CEST)
Message-ID: <fa751284-6c48-4879-8ab5-55441b5054dd@zimbra.xlogic.pl>
References: <BANLkTimt6jkTzO=UXnGhhiyh-+9vtUcUCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 81-18-210-90.static.chello.pl ([81.18.210.90]:59542 "EHLO
	mail.xlogic.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab1DKM1U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 08:27:20 -0400
In-Reply-To: <BANLkTimt6jkTzO=UXnGhhiyh-+9vtUcUCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zuh@iki.fi
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

> From: "Kalle Vahlman" <kalle.vahlman@gmail.com>
> 2011/4/11 Tomi Valkeinen <tomi.valkeinen@ti.com>
> > But you are right that normal user shouldn't need to read the TRM
> > if he
> > just wants to use scaling =). So either the sysfs/ioctl interfaces
> > should force the user to use things correctly, or he should get
> > clear
> > warnings/errors when he uses things incorrectly, or the
> > documentation
> > should say these things.
> 
> If the sysfs interface is not there, the questions will just turn
> from
> "why does it not work" to "why is there no sysfs entry"...

I believe there is a significant difference between 'why does it not work' and 'why is there no sysfs entry'.

The former (especially together with a non-descriptive debug message under omapdss.debug), indicates that it should work (interface present) but fails to do (for some reason - things like resolutions divisible by 16, integer scaling coefficients, etc were running through my head from past experience with scaler hardware).

The latter indicates that it shouldn't work (as intended by the developers - not present, not tested) - at least I'd be more likely to dig into TRM without assuming that it should be working (since someone put the interface to support it).

Best Regards,
Tomasz



