From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 0/5] ARM: omap3-lilly-a83x: update board support
Date: Fri, 23 May 2014 02:24:55 +0200
Message-ID: <1400804695.29278.2.camel@mars>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
	 <20140522232854.GD29577@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:64425 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaEWAZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 20:25:00 -0400
Received: by mail-la0-f45.google.com with SMTP id gl10so3410093lab.32
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 17:24:59 -0700 (PDT)
In-Reply-To: <20140522232854.GD29577@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2014-05-22 at 16:28 -0700, Tony Lindgren wrote:
> * Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> > This set of patches updates board support for omap3-lilly-a83x.
> > 
> > Christoph Fritz (5):
> >   [RFC-HACK] pinctrl-single: init by postcore_initcall()
> 
> I would prefer to start initializing other things later as
> then we get proper error messages on the console. Let's first
> investigate a bit more if we can just initialize other
> drivers later on.
> 
> Which version of kernel are you using? With all the fixes
> that have gone into this -rc cycle, v3.15-rc4 is pretty much
> the first kernel that should behave for us properly for
> deferred probe for irqchips that get initialized later on.

It's 3.15-rc6.



