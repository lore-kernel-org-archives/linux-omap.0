From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] OMAP: omap_device cleanup for v3.2
Date: Wed, 21 Sep 2011 11:39:22 -0700
Message-ID: <87ty853fl1.fsf@ti.com>
References: <87mxe5tlzv.fsf@ti.com> <87y5xps6kv.fsf@ti.com>
	<20110921182051.GH2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35491 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753525Ab1IUSj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 14:39:26 -0400
Received: by mail-yi0-f54.google.com with SMTP id 13so1776321yia.13
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 11:39:26 -0700 (PDT)
In-Reply-To: <20110921182051.GH2937@atomide.com> (Tony Lindgren's message of
	"Wed, 21 Sep 2011 11:20:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King <rmk@arm.linux.org.uk>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110915 16:23]:
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Please pull this omap_device cleanup series for v3.2.  This sets the
>> > groundwork for Benoit's DT infrastructure work.
>> 
>> Turns out this series has a dependency on a patch[1] in Russell's
>> for-next branch.
>> 
>> Russell, any chance of picking this patch into your devel-stable so we
>> have a fixed point to merge with?
>
> Or maybe Kevin can add it to his series instead?

Sure. 

Russell, if you're OK with dropping it from your for-next, I'll just
add it to my series where the dependencies are.

Kevin
