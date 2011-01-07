From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 14:07:53 +0100
Message-ID: <21BAFE00-CDAF-4DDB-9DC1-C42F0D61DC0E@dominion.thruhere.net>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34422 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab1AGNlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:41:47 -0500
Received: by wyb28 with SMTP id 28so17389524wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:41:46 -0800 (PST)
In-Reply-To: <20110107125132.GM1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Op 7 jan 2011, om 13:51 heeft Russell King - ARM Linux het volgende geschreven:
> This is the command line I've been giving it:
> 
> setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2'

Why are people still using rootdelay? 'rootwait' is vastly superior and doesn't need tweaking for every card/controller combo.

regards,

Koen