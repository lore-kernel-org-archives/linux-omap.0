From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 02/13] OMAP: DMA: Introduce errata handling feature
Date: Wed, 10 Nov 2010 08:26:13 -0800
Message-ID: <87hbfpcfh6.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-3-git-send-email-manjugk@ti.com>
	<87sjzakuxp.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40785 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837Ab0KJQ0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 11:26:15 -0500
Received: by pzk28 with SMTP id 28so146605pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 08:26:15 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Wed, 10 Nov 2010 19:32:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

[...]

>> > +	if (omap_type() == OMAP3430_REV_ES1_0)
>> > +		SET_DMA_ERRATA(DMA_ERRATA_i88);
>> > +
>> > +	/*
>> > +	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
>> 
>> This doesn't look like a unique errata identifier.  Chapter 3 
>> is usually
>> the 'Cautions' section, and I don't listed in either the 34xx (v5.9),
>> 36xx (v1.3) or 44xx (v1.3) errata docs under this number, and 
>> don't see
>> that number in either of the 24xx errata docs either.   
>> Please clarify.
>
> Even I tried to find this info from errata docs prior to migrating
> all errata's to generic errata handling. This code was exising earlier,
> hence I retained it "as is", no documentation exists for this errata.
>

Hmm, OK.  

According to the code, it seems to affect every IP execpt 1510, yet it's
not documented in any of the errata docs.  

I wonder what happens if it is removed?

Kevin
