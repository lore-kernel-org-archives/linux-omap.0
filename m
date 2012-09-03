From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: Few device tree patches for 3.7
Date: Mon, 3 Sep 2012 17:04:03 +0200
Message-ID: <5044C6E3.10304@ti.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com> <5035DC7C.2000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab2ICPEM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 11:04:12 -0400
In-Reply-To: <5035DC7C.2000105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

Hi Santosh,

Sorry for the delay, I missed that email :-(

On 08/23/2012 09:32 AM, Santosh Shilimkar wrote:
> Benoit,
> 
> On Monday 13 August 2012 04:30 PM, Santosh Shilimkar wrote:
>> These are the few device tree related patches which has been posted and
>> reviewed on the list. They are intended for 3.7 merge window but I am
>> posting them early enough to get into linux-next and linux-omap for
>> testing.
>>
>> The following changes since commit
>> 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
>>
>>    Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
>>
>> are available in the git repository at:
>>
>>    git://github.com/SantoshShilimkar/linux.git for_3.7/omap_dt
>>
>> for you to fetch changes up to bedee5fcb18062dfc933e0971e67fd6889c6446d:
>>
>>    ARM: OMAP4: Add local timer support for Device Tree (2012-08-13
>> 11:59:26 +0530)
>>
>> ----------------------------------------------------------------
>> Aneesh V (3):
>>        dt: device tree bindings for LPDDR2 memories
>>        dt: emif: device tree bindings for TI's EMIF sdram controller
>>        ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
>>
>> Santosh Shilimkar (2):
>>        ARM: OMAP4: Add L2 Cache Controller in Device Tree
>>        ARM: OMAP4: Add local timer support for Device Tree
>>
> 
> Will you pull this series from above git url or do you want me to send
> a separate git pull request email ?

I'll merge that branch on top of Sourav's and Peter's series and send
the pull request to Tony.

Regards,
Benoit

