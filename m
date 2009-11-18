From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/8] OMAP3 hwmod: Add automatic OCP_SYSCONFIG AUTOIDLE handling
Date: Wed, 18 Nov 2009 10:37:42 -0800
Message-ID: <874oord6h5.fsf@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
	<ce9ab5790911180045sa35c96bgc5d49fddc83d5ffc@mail.gmail.com>
	<alpine.DEB.2.00.0911180259330.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53052 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbZKRShn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 13:37:43 -0500
Received: by bwz27 with SMTP id 27so1445012bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 10:37:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180259330.25515@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 18 Nov 2009 03\:01\:07 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 18 Nov 2009, Vimal Singh wrote:
>
>> On Wed, Nov 18, 2009 at 6:35 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>> > From: Paul Walmsley <paul@pwsan.com>
>> >
>> > This patch fills in the OCP_SYSCONFIG.AUTOIDLE handling in the OMAP
>> > hwmod code.
>> >
>> > After this patch, the hwmod code will set the module AUTOIDLE bit (generally
>> > <module>.OCP_SYSCONFIG.AUTOIDLE) to 1 by default upon enable, and 1 upon
>> > disable.
>> 
>> You wanted to say:  "0 upon disable", isn't it?
>
> No, the original wording was intended, although it is somewhat confusing.
>
> This patch wasn't intended to be posted publicly; it combines two 
> unrelated changes that should be split.

Paul, sorry for posting this one.  I didn't mean to include it in this
series.

Kevin
