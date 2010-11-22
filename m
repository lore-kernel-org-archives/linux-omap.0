From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Mon, 22 Nov 2010 15:12:45 -0800
Message-ID: <87mxp1kl5e.fsf@deeprootsystems.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>
	<87oc9hm0zz.fsf@deeprootsystems.com> <4CEAF45B.5050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33870 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757660Ab0KVXMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 18:12:47 -0500
Received: by pxi15 with SMTP id 15so1691755pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 15:12:47 -0800 (PST)
In-Reply-To: <4CEAF45B.5050907@ti.com> (Nishanth Menon's message of "Mon, 22
	Nov 2010 16:53:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 11/22/2010 04:45 PM:
>>>   static inline int omap3_opp_init(void)
>>> >    {
>>> >    	return -EINVAL;
>>> >    }
>>> >  +static inline int omap4_opp_init(void)
>>> >  +{
>>> >  +	return -EINVAL;
>>> >  +}
>>> >    #endif
>> Now that these are device_initcalls, seems like they can be made static
>> and not callable externally.
>
> how do we handle boards that need custom opp table modifications?

um..., er... ok, I was just testing to see if you were awake today.  :/

Clearly I'm not remembering even my own feature suggestions.  Sorry for
the noise.  Guess I'm trying to review too many different series today.

Kevin

