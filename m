From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod core upgrades for 2.6.38: first set
Date: Mon, 22 Nov 2010 13:56:54 -0800
Message-ID: <87y68lnhsp.fsf@deeprootsystems.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1011160945100.32653@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59026 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256Ab0KVV46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 16:56:58 -0500
Received: by gwb19 with SMTP id 19so312866gwb.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 13:56:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011160945100.32653@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 16 Nov 2010 09:47:26 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 16 Nov 2010, Paul Walmsley wrote:
>
>> This patch series contains upgrades for the OMAP2+ hwmod core
>> code, intended for 2.6.38.  Most of these patches were developed
>> in response to use-cases discovered while converting device
>> drivers to use the hwmod code.
>> 
>> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.
>
> Just FYI, this branch 'hwmod_a_2.6.38' is available at 
> git://git.pwsan.com/linux-2.6
>
> Warning: it's based on Tony's tree, not the mainline, due to the recent 
> board file changes.

Looks like Tony has collected the board file changes into his
devel-board branch.  Can this rebased there?

That way, I can included it as part of the PM branch testing without
having to pull in master.

Thanks,

Kevin


