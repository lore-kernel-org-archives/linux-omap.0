From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
Date: Thu, 23 Sep 2010 16:53:02 -0700
Message-ID: <87wrqcnhk1.fsf@deeprootsystems.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF51AF@dbde02.ent.ti.com>
	<87d3sgs1nw.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE85CD@dbde02.ent.ti.com>
	<87mxr84gip.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE8768@dbde02.ent.ti.com>
	<87y6asqc9u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56635 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab0IWXxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 19:53:05 -0400
Received: by iwn5 with SMTP id 5so1846326iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 16:53:04 -0700 (PDT)
In-Reply-To: <87y6asqc9u.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 23 Sep 2010 16:18:53 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

>>
>> We cannot do a get_sync() from ISR context, right?
>
> Right, but we *should* be able to.  ;)
>
> I'm still trying to craft a good description of this problem so I can
> argue better for it on linux-pm.
>
> Until then...
>
> A bit of a hack, but you could do a _get_noresume() (which is safe from
> interrupt context) and directly call the drivers ->runtime_resume()
> method, which would be the equivalent of a _get_sync().  Followed of
> course by a _put() (async version, also interrupt safe) at the end of
> the ISR to keep the usecount correct.

You probably figured this out already, but I just realized that this
won't currently work either as omap_hwmod is using mutexes, and is 
safe in ISR context either. :(

What about for now just directly enabling (and re-disabling) the hwmod
clocks in the ISR using omap_hwmod_[enable|disable]_clocks()

Since this is a core driver in arch/arm/*omap*, you can directly call
the omap_hwmod API.

Kevin

