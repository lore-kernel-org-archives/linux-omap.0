From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [PATCH] Remove duplicate Kconfig LEDS_LP5521 entry introduced by 67a32ec7
Date: Wed, 24 Jun 2009 12:42:49 +0200
Message-ID: <87ab3xj4k6.fsf@small.ssi.corp>
References: <871vpaj9d1.fsf@small.ssi.corp> <20090624085914.GA16639@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:45263 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbZFXKmW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jun 2009 06:42:22 -0400
In-Reply-To: <20090624085914.GA16639@nokia.com> (Felipe Balbi's message of
	"Wed, 24 Jun 2009 11:59:14 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Felipe,

Felipe Balbi <felipe.balbi@nokia.com> writes:

> On Wed, Jun 24, 2009 at 10:59:06AM +0200, ext Arnaud Ebalard wrote:
>> Hi,
>> 
>> While playing with kernel configuration for my N810, I noticed a
>> duplicate config entry for LEDS_LP5521.
>> 
>> AFAICT, it was added by commit 67a32ec7 (leds: introduce lp5521 led
>> driver) but the entry was already there from 43350bf4 (leds: lp5521:
>> move to drivers/leds).
>> 
>> Following patch is against current linux-omap tree.
>
> probably automerge issues.

I have no clue on how it happened. After noticing the duplication, I
just did a git annotate to get some info and then took a look at
associated patches.

Cheers,

a+
