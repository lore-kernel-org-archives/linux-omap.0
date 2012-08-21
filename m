From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RFC/PATCH 4/4] gpio: smscece: Add support for gpio IO expander
 feature
Date: Tue, 21 Aug 2012 17:50:28 +0530
Message-ID: <CAKdam55SqXiCGv766yxoY1GdDjxNCYNaDdNZPaeLTAXc+3+c6g@mail.gmail.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-5-git-send-email-sourav.poddar@ti.com>
 <20120821105333.GW10347@arwen.pp.htv.fi>
 <CAKdam56DiFpnoQwrHe1tjQWLMy5vP9ynstNj_n=OyMxkJJAUOA@mail.gmail.com>
 <20120821120052.GD10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120821120052.GD10347@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Aug 21, 2012 at 5:30 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Aug 21, 2012 at 05:17:37PM +0530, Poddar, Sourav wrote:
>> >> +     if (type & IRQ_TYPE_LEVEL_HIGH)
>> >> +             sg->int_lvl[bank] |= bit;
>> >> +     else if (type & IRQ_TYPE_LEVEL_LOW)
>> >> +             sg->int_lvl[bank] &= ~bit;
>> >> +     else
>> >> +             return -EINVAL;
>> >
>> > this looks wrong. You could have a user who wants to trigger on both
>> > HIGH and LOW levels, no ?
>> >
>> Yes, I think there can be a scenario where gpio_keys are attached
>> to this driver and signals a "key press" at low and "key release" at
>> high. ?
>>  Will figure out a way to add support to check for case where
>> both High and low levels are used.
>
> could probably be done on a separate patch, maybe... Just now I saw that
> HIGH and LOW levels use the same bit.
>
If I am understanding correctly, if they both uses the same bit we cannot
use both for a particular user. ?
> --
> balbi
