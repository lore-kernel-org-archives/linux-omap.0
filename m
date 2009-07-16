From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 00/13] DSPBRIDGE: Patchset with various fixes
Date: Thu, 16 Jul 2009 09:53:12 +0300
Message-ID: <4A5ECE58.4010408@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com> <4A5E2BAA.3030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24635 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZGPGyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 02:54:08 -0400
In-Reply-To: <4A5E2BAA.3030007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Nishant,

ext Nishanth Menon wrote:
> Ameya Palande had written, on 07/15/2009 09:56 AM, the following:
>> Most of them have already got an ack, but can you please verify them again?
>> Following patches need an ack:
>>
>> [PATCH 04/13] DSPBRIDGE: fix macros that break when inside an if/else
>> [PATCH 05/13] DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
>> [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while moving to off mode
>> [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp hibernation
> Is there a 13/13? [1] shows 12/13 max..
> 
> Regards,
> Nishanth Menon
> 
> Ref:
> [1] http://marc.info/?l=linux-omap&r=1&b=200907&w=2

Sorry for the confusion!
13th Patch is: 0013-DSPBRIDGE-add-debug-prints-for-SR-DVFS-problem.patch
It is only helpful for debugging hence not included in final patchset.

Cheers,
Ameya.
