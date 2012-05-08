From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 8 May 2012 16:03:29 +0200
Message-ID: <4FA927B1.4020108@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
 <20120426180719.GC20186@mudshark.cambridge.arm.com> <4FA45580.8070802@ti.com>
 <87ipg76hfm.fsf@ti.com> <4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com>
 <4FA8FCFF.40105@ti.com>
 <CAORVsuWMhVQkQAmsyrprvW-0hK4y=RgGayn0p8WhyksScauBQQ@mail.gmail.com>
 <4FA9138D.8010604@ti.com>
 <CAORVsuWQ6o64Jhpox0ZvjYAfzDJkXCc6XYX2a6o_cOdNyFdA0g@mail.gmail.com>
 <87aa1isrg2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87aa1isrg2.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Jean Pihet <jean.pihet@newoldbits.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 5/8/2012 4:00 PM, Kevin Hilman wrote:
> Jean Pihet<jean.pihet@newoldbits.com>  writes:
>
> [...]
>
>>>>> Yes, indeed, we should not hack the flags to fix that kind of issue. The
>>>>> flags describe what the HW is capable of, and the EMU CD can support
>>>>> HW_AUTO
>>>>> and SW_WAKEUP. AFAIK, the issue with that EMU CD is that the only valid
>>>>> next
>>>>> power state is OFF, meaning that no retention mode is supported. So any
>>>>> transition to idle will go to OFF and lead to a reset upon wakeup.
>>>>>
>>>>> That being said, being able to transition to OFF during idle is a
>>>>> perfectly
>>>>> valid state for most powerdomain in OMAP anyway, so we should be able to
>>>>> restore from OFF mode smoothly.
>>>>>
>>>>> It looks to me that what is missing here is *just* a restore path in the
>>>>> PMU/CTI code. But I'm probably missing some nasty details in this issue
>>>>> :-)
>>>>
>>>> Although it is perfectly feasible to have a seamless transition of the
>>>> EMU power domain, I think the PMU counters will not be accurate
>>>> anymore since they stop counting events when going to OFF and re-start
>>>> after the state restore.
>>>
>>>
>>> Good point, but I think the PMU might still works fine because located
>>> inside the MPU domain. AFAIR, only the path to access the PMU and the CTI is
>>> going to OFF and thus will be reset.
>>
>> Ever better point ;p Thanks for the precision.
>> In any case my point was: can we allow the EMU CD to go OFF or prevent
>> it from doing so? We need to answer that question first.
>>
>
> The idea I've suggested is to use runtime PM for this.  As long as the
> PMU is in use, it will be runtime PM enabled (and not allowed to go into
> HWSUP idle.)  When it is not used, it will be allowed to HWSUP idle, and
> then be reset.  The next time it is needed, the runtime resume will need
> to do a full re-init.

Oh, but does that mean that this driver is not pm_runtime adapted yet?

Benoit
