From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Mon, 05 Nov 2012 11:29:35 -0800
Message-ID: <87a9uv97c0.fsf@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
	<1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
	<50953E26.40906@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
	<5097D2D7.3090204@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433EC0337B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51961 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2KET3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 14:29:36 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4144892pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 11:29:36 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC0337B@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Mon, 5 Nov 2012 17:57:54 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> On Mon, Nov 05, 2012 at 20:23:11, Shilimkar, Santosh wrote:
> [...]
>> >
>> On OMAP the OCMC RAM is always clocked and doesn't need any special
>> clock enable. CM_L3_2_OCMC_RAM_CLKCTRL module mode field is read only.
>> Isn't it same on AMXX ?
>> 
>
> On AM33xx, OCMC RAM is in PER domain and the corresponding CLKCLTR module
> mode fields are r/w. OCMC RAM needs to be disabled as part of the DeepSleep0
> entry to let PER domain transition.

After DeepSleep0, the ROM code is being given an address in OCMC RAM to
jump to.  If OCMC RAM is disabled as part of suspend, this means that
OCMC RAM contents are maintained even though PER domain transitions?

If so, that needs to be more clearly documented.

Kevin

