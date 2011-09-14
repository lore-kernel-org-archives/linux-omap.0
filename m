From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Wed, 14 Sep 2011 10:18:00 -0700
Message-ID: <20110914171800.GO24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
 <20110913203616.GG24252@atomide.com>
 <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
 <20110914152116.GM24252@atomide.com>
 <4E70DB33.5070501@ti.com>
 <20110914170803.GN24252@atomide.com>
 <4E70E0CC.80300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:30429 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757098Ab1INRSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 13:18:03 -0400
Content-Disposition: inline
In-Reply-To: <4E70E0CC.80300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, "Woodruff, Richard" <r-woodruff2@ti.com>

* Santosh <santosh.shilimkar@ti.com> [110914 09:40]:
> On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
> >* Santosh<santosh.shilimkar@ti.com>  [110914 09:16]:
> >
> >Thanks for the clarification. It seems to me the spec is most likely
> >wrong as we've had the GIC working for over two years now without
> >doing anything with the wakeup gen registers :)
> >
> It's working because CPU clockdomain are never put under HW
> supervised mode and they are kept in force wakeup. Clock-domain
> never idles on mainline code. PM series will put the clock-domains
> under HW supervison as needed to achieve any low power states and
> then all sorts of corner cases will come out.

But again the wakeup gen triggers only do something when hitting
idle. There should be no use for them during runtime, right?

Tony
