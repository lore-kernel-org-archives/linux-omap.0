From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different OPP types
Date: Tue, 12 Jan 2010 11:26:22 -0800
Message-ID: <87wrzn86qp.fsf@deeprootsystems.com>
References: <1263299979.1536.7.camel@boson>
	<87iqb7fdgf.fsf@deeprootsystems.com>
	<74583B8642AB8841B30447520659FCA9E73BDA08@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49067 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab0ALT01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 14:26:27 -0500
Received: by ywh6 with SMTP id 6so22765199ywh.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 11:26:25 -0800 (PST)
In-Reply-To: <74583B8642AB8841B30447520659FCA9E73BDA08@dnce01.ent.ti.com> (Benoit Cousson's message of "Tue\, 12 Jan 2010 18\:36\:37 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>Sent: Tuesday, January 12, 2010 6:19 PM
>>To: Dasgupta, Romit
>>Cc: Menon, Nishanth; linux-omap@vger.kernel.org
>>Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing
>>different OPP types
>>
>>Romit Dasgupta <romit@ti.com> writes:
>>
>>> Introduces enum for identifying OPP types. This helps in querying the OPP
>>> layer by passing the type of OPP (enum types) and gets away from
>>maintaining
>>> the pointer to the OPP data list outside the OPP layer.
>>>
>>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>>
>>I like this idea... but I have some questions about how we should
>>cleanly handle SMP and future SoCs.
>
> Well, it is better than what we have today, but maybe not super
> scalable for next device. This information is completely device
> dependant and should not be in a plat-omap file.  In that case, it
> will be tricky to have an enum per devices because it will prevent
> multiple omap build.  That for that reason that I think we might use
> hwmod to identify the relevant scalable IPs, instead of yet another
> identifier for something that is IP related.

OK.  Let's take this approach for now, and after hwmods get
stabilized/merged we can consider alternate per-SoC ways to handle
this.

Thanks,

Kevin
