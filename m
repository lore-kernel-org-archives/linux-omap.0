From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
Date: Wed, 13 Jun 2012 10:39:52 -0500
Message-ID: <4FD8B448.9090405@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com> <4FD66666.8060002@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998201@DBDE01.ent.ti.com> <4FD785DC.2000106@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998820@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45008 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab2FMPjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 11:39:52 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998820@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 12:50 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 23:39:32, Hunter, Jon wrote:
>> On 06/12/2012 07:58 AM, Mohammed, Afzal wrote:
> 
>>> Thinking again over it, I am feeling above is sufficient, reason same as
>>> said earlier, to keep code simple & currently this is sufficient to
>>> handle GPMC bit patterns for IPs presently available. What you are
>>> suggesting is to take care of the imaginary case when new GPMC IP happens
>>> with new device type or size, I think that should be handled when such a
>>> scenario happens. Probably, it is better here to add a comment to make
>>> intention clear.
>>
>> That is one possibility but I think that more important reasons are ...
>>
>> 1. Readability, at first it appears that we are always configuring the
>> CS for NAND. However, this is not the case. Maybe a comment here can
>> help as you mentioned.
> 
> As far as the users of GPMC is considered there is no confusion. Eg. For
> device type, they have been provided with two macros,
> 
> GPMC_CONFIG1_DEVICETYPE_NOR, GPMC_CONFIG1_DEVICETYPE_NAND
> 
> So for NOR, user can feel satisfied by giving NOR flag, little does he know
> that driver doesn't do anything with the flag, but he still gets what he want
> NOR flag is defined as zero. Yes even if he doesn't specify any type, device
> type will be set as NOR, but then that is the default - the only other option

Sure, but reviewing the function it still looks odd from a readability
standpoint. At least it made me think "what is going on here ...". So a
comment is definitely needed.

>>
>> 2. A bad setting in the configuration passed. Hopefully, people will
>> stick to the flags but we know that we expect the device type to be a 0
>> or 2 and so should we check?
> 
> Value of device type is something driver has to worry about, not its users,
> they have been provided with two flags, one for NAND & other for NOR.

Yes, but the driver does not seem to worry about it. In other words,
there is no error checking. Ok so not a big deal a comment should suffice.

Jon


