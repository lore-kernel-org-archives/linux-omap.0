From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Thu, 16 Jul 2015 10:09:23 +0300
Message-ID: <55A758A3.2070108@ti.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <55A4DFEF.6040005@ti.com> <55A52208.5060302@ti.com>
 <alpine.DEB.2.02.1507160014371.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1507160014371.32764@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2015 03:15 AM, Paul Walmsley wrote:
> On Tue, 14 Jul 2015, Tero Kristo wrote:
>
>> On 07/14/2015 01:09 PM, Lokesh Vutla wrote:
>>> Hi,
>>> On Wednesday 10 June 2015 02:56 PM, Lokesh Vutla wrote:
>>>> Some IP blocks like RTC, needs an additional unlocking mechanism for
>>>> writing to its registers. This patch adds optional lock and unlock
>>>> function pointers to the IP block's hwmod data which gets executed
>>>> before and after writing into IP sysconfig register.
>>>> And also hook lock and unlock functions to AMx3xx, DRA7 RTC hwmod data,
>>>> so that sysconfig registers are updated properly.
>>> ping on this series.
>>>
>>> Thanks and regards,
>>> Lokesh
>>
>
> [...]
>
>> It is also racy, as there is no locking in place to avoid concurrent access to
>> the lock/unlock registers across hwmod+driver.
>
> I don't see the race.  Where is it?

See drivers/rtc/rtc-omap.c, am3352_rtc_unlock and am3352_rtc_lock.

That code is accessing the exact same registers.

-Tero
