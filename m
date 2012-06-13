From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
Date: Wed, 13 Jun 2012 10:44:30 -0500
Message-ID: <4FD8B55E.6010701@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com> <4FD6783D.9030208@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com> <4FD78748.2080504@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab2FMPoa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:44:30 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 02:37 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 23:45:36, Hunter, Jon wrote:
> 
>> GPMC_WAITPIN_IDX0 = 0
>> GPMC_WAITPIN_0 = 1
>>
>> So, GPMC_WAITPIN_IDX0 = GPMC_WAITPIN_0 - 1, assuming that you want idx =
>> 0 and not 1. Or you could change you shift value too. I was just
>> highlighting that they are not equal but one set of definitions could be
>> used.
> 
> In that case we would be directly depending on user flag whose value may
> or may not change and I don't think it is good to directly depend on it
> for waitpin # calculation.

You are already dependent on it. In other words, you are going to set
the waitpin # according to these flags in the first place. I don't see
the difference.

Bottom line is that we don't need to have multiple definitions for the
same thing.

Jon
