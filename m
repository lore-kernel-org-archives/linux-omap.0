From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during suspend
Date: Wed, 12 Sep 2012 16:11:37 -0700
Message-ID: <87sjamsuom.fsf@deeprootsystems.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
	<1342704392-23657-8-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
	<1342711907.4672.153.camel@sokoban>
	<alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55829 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2ILXLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 19:11:38 -0400
Received: by obbuo13 with SMTP id uo13so3531226obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 16:11:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 19 Jul 2012 17:30:12 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

[...]

>
> It kind of looks to me like there are two or three separate sets within 
> the series.  My feeling is that Kevin should take the first two, then I 
> should take the rest other than 6 and 7.  Then once those are queued, 
> we can pull in 6 and 7.  Does that make sense to you?
>

Looks like 1, 2 & 7 are needed for OSWR, and the rest can go now via
Paul.

Tero, can create a new OSWR series including 1, 2 & 7?  Can you also
refresh it against Jean's latest functional power state series (v6)?

Thanks,

Kevin


