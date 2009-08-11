From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 0/6] Basic OMAP4 PRCM register def series
Date: Tue, 11 Aug 2009 16:31:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050129@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0908110437100.17390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <alpine.DEB.2.00.0908110437100.17390@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org


>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: Tuesday, August 11, 2009 4:09 PM
>To: Nayak, Rajendra; linux-omap@vger.kernel.org
>Cc: linux-arm-kernel@lists.arm.linux.org.uk
>Subject: Re: [PATCH 0/6] Basic OMAP4 PRCM register def series
>
>Hi Rajendra,
>
>On Mon, 10 Aug 2009, Nayak, Rajendra wrote:
>
>> This series contains patches which define OMAP4430 
>PRM/CM1/CM2 module register offsets
>> and masks.
>> 
>> This series applies on top of v2.6.31-rc5.
>> 
>> Rajendra Nayak (6):
>>       ARM: OMAP4: PM: Fix the PRM and CM base addresses
>>       ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
>>       ARM: OMAP4: PM: Adds PRM register defs for OMAP4
>>       ARM: OMAP4: PM: Adds PRM register shift and mask bits
>>       ARM: OMAP4: PM: Adds CM1/2 register defs for OMAP4
>>       ARM: OMAP4: PM: Adds CM1/2 register field masks
>> 
>>  arch/arm/mach-omap2/cm.h                   |  249 +++++++-
>>  arch/arm/mach-omap2/cm1-regbits-44xx.h     |  315 ++++++++
>>  arch/arm/mach-omap2/cm2-regbits-44xx.h     |  541 ++++++++++++++
>>  arch/arm/mach-omap2/prcm-common.h          |   28 +
>>  arch/arm/mach-omap2/prcm.c                 |    2 +
>>  arch/arm/mach-omap2/prm-regbits-44xx.h     | 1063 
>++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/prm.h                  |  295 ++++++++-
>>  arch/arm/plat-omap/common.c                |    2 +
>>  arch/arm/plat-omap/include/mach/common.h   |    1 +
>>  arch/arm/plat-omap/include/mach/omap44xx.h |    6 +-
>>  10 files changed, 2497 insertions(+), 5 deletions(-)
>
>Please cc OMAP-related patches to the linux-omap mailing list, 
>linux-omap@vger.kernel.org, for review there.

I missed it this time, will make sure my upcoming patch sets
are copied to linux-omap list as well.

Btw, these were already posted on linux-omap list as RFC patches
for review.
http://marc.info/?l=linux-omap&m=124358593421800&w=2

>
>
>- Paul
>
>
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
