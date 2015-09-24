From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Thu, 24 Sep 2015 10:15:30 +0530
Message-ID: <56037FEA.5070807@ti.com>
References: <1437657946-10733-1-git-send-email-lokeshvutla@ti.com>
 <55DE9055.4090701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55DE9055.4090701@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: t-kristo@ti.com, tony@atomide.com, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Thursday 27 August 2015 09:51 AM, Lokesh Vutla wrote:
> Hi Paul,
> 
> On Thursday 23 July 2015 06:55 PM, Lokesh Vutla wrote:
>> This series implements lock and unlock functions for RTC and hooks
>> the same to DRA7 and AMx3xx hwmod.
>> This is dependent on the patch https://patchwork.kernel.org/patch/6578281/,
>> which is queued recently by Paul.
> Gentle ping on this series.
Do you have any comments on this series?

Thanks and regards,
Lokesh
> 
> Thanks and regards,
> Lokesh
>>
>> Changes since v2:
>> - Add kerneldoc for omap_hwmod_rtc_lock() function.
>>
>> Lokesh Vutla (3):
>>   ARM: hwmod: RTC: Add lock and unlock functions
>>   ARM: DRA7: RTC: Add lock and unlock functions
>>   ARM: AMx3xx: RTC: Add lock and unlock functions
>>
>>  arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
>>  arch/arm/mach-omap2/omap_hwmod_reset.c             | 65 ++++++++++++++++++++++
>>  4 files changed, 71 insertions(+)
>>
