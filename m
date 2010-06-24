From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Thu, 24 Jun 2010 10:52:02 -0700
Message-ID: <87hbkse2t9.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232310110.1550@utopia.booyaka.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032366B0A0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41600 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0FXRwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:52:05 -0400
Received: by pwj8 with SMTP id 8so1958171pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:52:04 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032366B0A0@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Thu, 24 Jun 2010 19:53:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Thursday, June 24, 2010 12:11 AM
>> To: Nayak, Rajendra
>> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Cousson, Benoit
>> Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
>> 
>> Hi Rajendra
>> 
>> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>> 
>> > From: Rajendra Nayak <rnayak@ti.com>
>> >
>> 
>> Please add a brief patch changelog entry here.  Maybe just say this is
>> necessary for integration code using omap_device to work on OMAP4?
>
> Yes, will do, not sure how that got missed. 

Rajendra,

If you just reply here with the changelog entry, I will update it in
this series.

This patch is needed in this series as the patch 
"OMAP: create omap_devices for MPU, DSP, L3"  depends on it.

Thanks,

Kevin
