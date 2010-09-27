From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
Date: Mon, 27 Sep 2010 07:53:07 -0700
Message-ID: <874odbutkc.fsf@deeprootsystems.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF51AF@dbde02.ent.ti.com>
	<87d3sgs1nw.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE85CD@dbde02.ent.ti.com>
	<87mxr84gip.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE8768@dbde02.ent.ti.com>
	<87y6asqc9u.fsf@deeprootsystems.com>
	<87wrqcnhk1.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C35B07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35969 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab0I0OxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 10:53:11 -0400
Received: by pxi10 with SMTP id 10so1411473pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Sep 2010 07:53:10 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930233C35B07@dbde02.ent.ti.com>
	(Partha Basak's message of "Sat, 25 Sep 2010 09:00:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

>  
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Friday, September 24, 2010 5:23 AM
>> To: Basak, Partha
>> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Tero 
>> Kristo; Cousson, Benoit
>> Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
>> interrupts-disabled idle path
>> 
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>> 
>> [...]
>> 
>> >>
>> >> We cannot do a get_sync() from ISR context, right?
>> >
>> > Right, but we *should* be able to.  ;)
>> >
>> > I'm still trying to craft a good description of this 
>> problem so I can
>> > argue better for it on linux-pm.
>> >
>> > Until then...
>> >
>> > A bit of a hack, but you could do a _get_noresume() (which 
>> is safe from
>> > interrupt context) and directly call the drivers ->runtime_resume()
>> > method, which would be the equivalent of a _get_sync().  Followed of
>> > course by a _put() (async version, also interrupt safe) at 
>> the end of
>> > the ISR to keep the usecount correct.
>> 
>> You probably figured this out already, but I just realized that this
>> won't currently work either as omap_hwmod is using mutexes, and is 
>> safe in ISR context either. :(
>> 
>> What about for now just directly enabling (and re-disabling) the hwmod
>> clocks in the ISR using omap_hwmod_[enable|disable]_clocks()
>> 
>> Since this is a core driver in arch/arm/*omap*, you can directly call
>> the omap_hwmod API.
>> 
>
> omap_hwmod_[enable/disable]_clocks() use mutex inside & therefore cannot
> be used in the ISR context
>
> We cannot readily use the _enable_clocks/_disble_clocks directly as they are
> static APIs.
>
> But we can use the non-mutex versions, of omap_hwmod_enable/idle.
> (_omap_hwmod_enable/_omap_hwmod_disable)
>
> Do you agree?

Yes, I meant to use the non-mutex versions.

Sorry,

Kevin
