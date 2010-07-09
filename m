From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/5] omap: Allow testing for omap type with 	omap_has_feature
Date: Fri, 9 Jul 2010 11:53:55 -0500
Message-ID: <4C375423.1090405@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com> <20100708093804.16352.82935.stgit@baageli.muru.com> <4C35E8D1.6030504@ti.com> <AANLkTimTBT_tNNB4GB7mvy1hAEcMrWsauIvjG_p33TD2@mail.gmail.com> <4C35FCBF.4020400@ti.com> <AANLkTinoIchxcoG-GBROttjr63ZxIRwFheQwZ4RAxnWn@mail.gmail.com> <4C3628FE.5030201@ti.com> <20100709070422.GC24913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab0GIQx7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 12:53:59 -0400
In-Reply-To: <20100709070422.GC24913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 07/09/2010 02:04 AM, the following:
> * Nishanth Menon <nm@ti.com> [100708 22:31]:
>>>    I think this 'lazy reviewability'  comes at the cost of very
>>> abstraction  the features framework is intended to provide, not to
>>> mention the question of correct selection (is this a OMAP4 specific
>>> feature or is OMAP5 expected to have it ?). and upgradation.
>>>
>>>    As mentioned before, the surrounding context of the use of
>>> omap_has_feature() will provide enough clues about the cpu specific
>>> nature of a feature, if at all needed.
>> Does it really? when a new feature is added, dont we want to know if
>> it is generic feature or a omap specific feature? where is the flag?
> 
> Yeah I don't know what we should do with these defines.. Kind of just
> threw the patch out there.
> 
> If we already have omap specific omap_has_feature functions, we don't
> need cpu_is_omapxxxx in most cases.
> 
> I suggest we only use the generic defines now, then look at it again
> when we run out of the bits to define.
ack.

-- 
Regards,
Nishanth Menon
