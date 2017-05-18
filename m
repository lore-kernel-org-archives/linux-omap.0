From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Thu, 18 May 2017 09:19:32 -0500
Message-ID: <0bf4723f-dd94-bbbf-21a8-2ec60dff58cb@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
 <20170329171314.GD10760@atomide.com>
 <cd340d7a-c0cf-9227-1382-2277ffa5b1b0@ti.com>
 <20170516154717.GF31418@atomide.com>
 <597b3b18-154d-9e81-35c3-4790d813031b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <597b3b18-154d-9e81-35c3-4790d813031b@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,
On 05/16/2017 10:49 AM, Dave Gerlach wrote:
> On 05/16/2017 10:47 AM, Tony Lindgren wrote:
>> * Dave Gerlach <d-gerlach@ti.com> [170329 11:52]:
>>> Hi Tony,
>>> On 03/29/2017 12:13 PM, Tony Lindgren wrote:
>>>> * Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
>>>>> Hi,
>>>>> This series contains the remaining code to enable suspend to mem and
>>>>> standby on
>>>>> am335x and am437x platforms. It depends on the ti-emif-sram series sent
>>>>> here [1].
>>>>
>>>> Looks good to me in general. To remove the dependency, can some
>>>> of this be merged separately without breaking things before [1]?
>>>> Maybe by disabling some of the PM states until [1] is in place?
>>>
>>> Thanks for the feedback. Actually, patch 7 is the only patch with a
>>> dependency to [1]. The rest of the patches just add platform PM support
>>> needed for suspend but won't do much of anything until patch 7 actually
>>> enables the suspend states, so there is no reason why patches 1-6 and patch
>>> 8 can't be merged now.
>>
>> I'm applying patches 1-5 into omap-for-v4.13/soc. Patch 6 needs
>> ack from Russell.
>>
>
> Thanks. I will resend patches 6-8 as a separate series.

On second thought, it's probably best to keep patches 4 and 5 as part of the new 
series as well for review purposes, as they are not added to the build until 
patch 6 but also make use of the asm-offsets macros introduced in patch 6. I 
will send them along with patch 6-8 resend, making the new series patches 4-8.

Regards,
Dave

>
> Regards,
> Dave
>
>> Regards,
>>
>> Tony
>>
>
