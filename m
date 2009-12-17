From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Low level debugging using CONFIG_EARLY_PRINTK=y, omap-debug branch removed
Date: Thu, 17 Dec 2009 15:38:15 -0800
Message-ID: <874onp41eg.fsf@deeprootsystems.com>
References: <20091216005337.GR4575@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BFB58018@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0912171603040.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:50427 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbZLQXiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 18:38:20 -0500
Received: by ywh12 with SMTP id 12so2862348ywh.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 15:38:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912171603040.12561@utopia.booyaka.com> (Paul Walmsley's message of "Thu\, 17 Dec 2009 16\:04\:17 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 16 Dec 2009, Shilimkar, Santosh wrote:
>
>> I tried this on couple of boards and at least it doesn't work with the 
>> options and mentioned bootargs. The low level debug prints are still not 
>> coming on console.
>> 
>> I haven't debugged it though.
>
> It works on Beagle, at least.  That's the only one that I've tested so 
> far.
>

I've been using the earlyprink patch for PM debug on several OMAP3
boards without any problems.

Kevin
