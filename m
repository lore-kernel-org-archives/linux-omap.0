From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
Date: Thu, 1 Sep 2016 10:00:22 -0500
Message-ID: <de3bf6ab-a07a-b82d-1e45-5f96a6e1039e@ti.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
 <20160901145757.4oksrst3wpjpsscf@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160901145757.4oksrst3wpjpsscf@atomide.com>
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
Cc: "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 09/01/2016 09:57 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160901 07:15]:
>> On 09/01/2016 09:12 AM, Robert Nelson wrote:
>>> On Thu, Sep 1, 2016 at 9:09 AM, Nishanth Menon <nm@ti.com> wrote:
>>>> On 09/01/2016 08:51 AM, Tomi Valkeinen wrote:
>>>>>
>>>>> LS_OE GPIO was changed from gpio6_28 to gpio2_30 for the Rev B1 board,
>>>>> and the current .dts file has the old GPIO.
>>>>>
>>>>> Rev B1 is the earliest board supported, so we can just change the .dts.
>>>>>
>>>>> This fixes "omapdss error: HDMI I2C Master Error" which causes failure
>>>>> to read EDID from the monitor.
> ...
>>>> I believe we have A2s being shipped as well. we dont want to break A2s
>>>> either -> I propose we refactor the dts to introduce revb1 X15.
>>>
>>> There are at-least 200 A2's that have been shipped to end users.
>>>
>>> http://uk.rs-online.com/web/p/processor-microcontroller-development-kits/8874764/
>>
>>
>> Thanks. Tomi: if you are ok - I already do have a refactoring code from
>> older kernel. I will rebase to latest and repost.
>>
>> Tony: is there a branch youd' like me to base the changes on?
>
> Probably best to do it against current omapf-for-v4.9/dt as it has all
> the skeleton.dtsi removal now applied.

Ok will do, will try to post this later today or early tomorrow.


-- 
Regards,
Nishanth Menon
