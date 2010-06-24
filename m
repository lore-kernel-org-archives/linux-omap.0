From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/13] OMAP: hwmod: add non-locking versions of enable and idle functions
Date: Thu, 24 Jun 2010 10:55:56 -0700
Message-ID: <87wrtoco2b.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-7-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232307170.1550@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E776178B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44963 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab0FXR4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:56:06 -0400
Received: by pvg2 with SMTP id 2so466190pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:56:06 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E776178B@dbde02.ent.ti.com>
	(Partha Basak's message of "Thu, 24 Jun 2010 18:29:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Basak, Partha" <p-basak2@ti.com> writes:

[...]

>> >  /**
>> >   * omap_hwmod_idle - idle an omap_hwmod
>> >   * @oh: struct omap_hwmod *
>> > @@ -1319,9 +1345,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
>> >  	if (!oh)
>> >  		return -EINVAL;
>> >
>> > -	mutex_lock(&omap_hwmod_mutex);
>> > -	_idle(oh);
>> > -	mutex_unlock(&omap_hwmod_mutex);
>> > +	__omap_hwmod_idle(oh);
>> >
>
> BTW: The mutex locks are missing. Typo?
>

Good catch Partha.  

I wish I could explain that as only a typo.  Unfortunately, it was just
a "not paying close enough attention" mistake.

Thanks,

Kevin
