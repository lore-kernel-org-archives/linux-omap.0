From: Bill Traynor <btraynor@gmail.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
Date: Mon, 13 Nov 2017 19:27:06 -0500
Message-ID: <CAN20qYqq9DGSgcTaivZHrD+RMY1WLPLNGv2K7xp0pvArJWuGEg@mail.gmail.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
 <20160901145757.4oksrst3wpjpsscf@atomide.com>
 <de3bf6ab-a07a-b82d-1e45-5f96a6e1039e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <de3bf6ab-a07a-b82d-1e45-5f96a6e1039e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 1, 2016 at 11:00 AM, Nishanth Menon <nm@ti.com> wrote:
> On 09/01/2016 09:57 AM, Tony Lindgren wrote:
>>
>> * Nishanth Menon <nm@ti.com> [160901 07:15]:
>>>
>>> On 09/01/2016 09:12 AM, Robert Nelson wrote:
>>>>
>>>> On Thu, Sep 1, 2016 at 9:09 AM, Nishanth Menon <nm@ti.com> wrote:
>>>>>
>>>>> On 09/01/2016 08:51 AM, Tomi Valkeinen wrote:
>>>>>>
>>>>>>
>>>>>> LS_OE GPIO was changed from gpio6_28 to gpio2_30 for the Rev B1 board,
>>>>>> and the current .dts file has the old GPIO.
>>>>>>
>>>>>> Rev B1 is the earliest board supported, so we can just change the
>>>>>> .dts.
>>>>>>
>>>>>> This fixes "omapdss error: HDMI I2C Master Error" which causes failure
>>>>>> to read EDID from the monitor.
>>
>> ...
>>>>>
>>>>> I believe we have A2s being shipped as well. we dont want to break A2s
>>>>> either -> I propose we refactor the dts to introduce revb1 X15.
>>>>
>>>>
>>>> There are at-least 200 A2's that have been shipped to end users.
>>>>
>>>>
>>>> http://uk.rs-online.com/web/p/processor-microcontroller-development-kits/8874764/
>>>
>>>
>>>
>>> Thanks. Tomi: if you are ok - I already do have a refactoring code from
>>> older kernel. I will rebase to latest and repost.
>>>
>>> Tony: is there a branch youd' like me to base the changes on?
>>
>>
>> Probably best to do it against current omapf-for-v4.9/dt as it has all
>> the skeleton.dtsi removal now applied.
>
>
> Ok will do, will try to post this later today or early tomorrow.

I'm getting this error again with the latest X15 image on my A2
version board.  I don't see this patch in the mainline kernel.  Did it
never get applied?

Thanks
Bill

>
>
> --
> Regards,
> Nishanth Menon
>
> --
> You received this message because you are subscribed to the Google Groups
> "beagleboard-x15" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to beagleboard-x15+unsubscribe@googlegroups.com.
> To post to this group, send email to beagleboard-x15@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/beagleboard-x15/de3bf6ab-a07a-b82d-1e45-5f96a6e1039e%40ti.com.
>
> For more options, visit https://groups.google.com/d/optout.
