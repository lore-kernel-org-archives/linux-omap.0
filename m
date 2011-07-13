From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Wed, 13 Jul 2011 16:51:24 -0700
Message-ID: <87vcv5n3ib.fsf@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
	<87r55uxay2.fsf@ti.com>
	<20110713232228.GC9770@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44090 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752883Ab1GMXv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 19:51:29 -0400
Received: by mail-iw0-f182.google.com with SMTP id 19so7463520iwr.41
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 16:51:28 -0700 (PDT)
In-Reply-To: <20110713232228.GC9770@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Thu, 14 Jul 2011 08:22:30 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, lrg@ti.com, Paul Walmsley <paul@pwsan.com>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Jul 13, 2011 at 12:00:37PM -0700, Kevin Hilman wrote:
>
>> Actually, I'd prefer it stay in drivers/regulator.  We're trying to move
>> driver-type stuff out of arch/arm/* into the right place in drivers/*.
>> In fact, I wonder if our VP/VC layers might better live under
>> drivers/regulator also.
>
> Well, if they don't look hideous in the API then sure.  I'd guess it's
> probably a case of lifting the implementation APIs that Tero's driver is
> calling up into the regulator driver he's writing.

Basically, yes.  But it also would mean dragging the rest of the VC/VP
APIs along as well.

I'll work in this direction and hopefully have some better RFC type code
to show soonish.

Thanks,

Kevin
