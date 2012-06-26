From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Tue, 26 Jun 2012 09:39:07 -0500
Message-ID: <4FE9C98B.2020003@ti.com>
References: <cover.1340354985.git.afzal@ti.com> <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com> <4FE88DDE.60601@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E99F002@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58518 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757004Ab2FZOjJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 10:39:09 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99F002@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/26/2012 03:29 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Mon, Jun 25, 2012 at 21:42:14, Hunter, Jon wrote:
>> On 06/22/2012 04:01 AM, Afzal Mohammed wrote:
> 
>>> +static int hf, vhf, sync_read, sync_write, latency;
>>
>> I am wondering if we can remove hf, vhf, sync_read/write variables
>> completely. We already have flags from sync_read/write and so we could
>> just use the cfg->flags variable and remove sync_read/write variables.
> 
> For default frequency, sync_write can get turned off, so flag may or
> may not be same as sync_write

Good point. I missed that.

>>
>> At the same time, we could create flags for ONENAND_FREQ_HF and
>> ONENAND_FREQ_VHF or something like that. It could be nice to store the
>> latency in onenand_data too. In other words, keep all the configuration
>> in one place.
> 
> I have a feeling as though platform data fields should not be altered once
> platform device is registered (as platform data being specific to the
> board, thinking further, should they be const?, except for a case
> where it is created by a common helper function for multiple boards with
> varying capabilities of peripheral).
> 
> Other than sync_read, all others like hf, vhf, latency, sync_write are
> updated during driver callback, so if we are going to put these in
> platform private data fields, platform private data fields has to be
> updated after platform device is registered.

May be this is splitting hairs then but I wonder if we should just have
a single global variable called onenand_flags for storing the current
state of sync_read, sync_write, vhf and hf. At least this would be only
one global instead of 4. Not a big deal.

Cheers
Jon
