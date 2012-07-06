From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: miscellaneous PRCM & hwmod patches for 3.6
Date: Fri, 6 Jul 2012 14:04:51 +0530
Message-ID: <CAMQu2gzRztCfRuQEdSjx0c1RN5b5E67A2NBhE-s0_R07FaRCdw@mail.gmail.com>
References: <alpine.DEB.2.00.1207040935070.6760@utopia.booyaka.com>
 <20120705084002.GU1122@atomide.com>
 <CAMQu2gwuXnV7E8-+x9EN0qRF9B2OOgY3KMW-nd0GAqHUwHXkGw@mail.gmail.com>
 <20120706080943.GL1122@atomide.com>
 <CAMQu2gyA0XF01gi_2Y_7eOY+NFKPidY6dUah3Rh-FnqpC37vfg@mail.gmail.com>
 <20120706083023.GP1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120706083023.GP1122@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 6, 2012 at 2:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120706 01:32]:
>> On Fri, Jul 6, 2012 at 1:39 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120705 04:26]:
>> >>
>> >> Looks like the merge has not happened correctly.
>> >> I see from the commit log that, you had a merge conflict in omap_hwmod.c
>> >> and probably while resolving that the below change got missed.
>> >>
>> >> Tarun Kanti DebBarma (1):
>> >>       ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
>> >>
>> >> So I tried pulling Paul's branch again on "cleanup-part2" at commit 8cb8de5d87
>> >> and it got merged without any conflicts.
>> >>
>> >> Do you want to re-merge Paul's series in cleanup-part2 or re-apply the above
>> >> patch ?
>> >
>> > Hmm weird, I wonder how I managed to mess up the resolve like that..
>> > I'll (re)apply the following fix as the branch has been pushed out already.
>> >
>> Sounds good to me. Can you update the barcnh please ?
>> I don't see that patch yet in cleanup-part2.
>
> Pushed out now at commit ae6df418 (ARM: OMAP2+: dmtimer: cleanup fclk usage)
> also applied. Might take a while for it to get mirrored.
>
Great. Thanks !!

Regards
Santosh
