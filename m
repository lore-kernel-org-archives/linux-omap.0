From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/9] OMAP: DMTIMER: Convert platform driver so as to make use of hwmod + omap device framework for OMAP2 PLUS
Date: Thu, 03 Jun 2010 15:20:17 -0700
Message-ID: <878w6vn4gu.fsf@deeprootsystems.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
	<4C02E275.2080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57344 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0FCWUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 18:20:20 -0400
Received: by pwj2 with SMTP id 2so293833pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 15:20:19 -0700 (PDT)
In-Reply-To: <4C02E275.2080202@ti.com> (Benoit Cousson's message of "Mon\, 31 May 2010 00\:11\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> On 5/29/2010 4:37 PM, Gopinath, Thara wrote:
>> This patch series converts the OMAP Dual Mode Timer into a
>> platform driver. This involves using of hwmod structures and
>> omap_device layer for OMAP2/3/4 dmtimers and generic
>> linux platform device layer for OMAP1.
>>
>> As a result of this patch series the dmtimer platform driver
>> resides in arch/arm/plat-omap directory and arch specific
>> implementations and device registerations reside in
>> arch/arm/mach-omap1 and arch/arm/mach-omap2 for OMAP1
>> and OMAP2 PLUS respectively.
>
> Hi Thara,
>
> The Dual timer terminology is not used anymore since 2420.
> It was replaced by gptimer and will be simplified going forward
> using timer. This IP is almost the same since 1610, but will have 3
> different names.
> It might be the good opportunity to align the names?

If we were to align the names, what should be the "aligned" name?
gptimer or timer?  I tend to prefer gptimer as 'timer' is rather
ambiguous in this context.

For now, we could leave the names of all the functions and structs as
'dm_timer', but at least this serious could name the new files and the
platform devices with the new name.  At the end of the series, one
final patch to s/dm_timer/new_beautiful_name/ would be an easy patch.

Kevin
