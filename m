From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/8] time: Add persistent clock support
Date: Mon, 25 Jun 2018 22:06:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1806252142261.1587@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org>
 <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
 <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, alexandre.belloni@bootlin.com, x86@kernel.org, =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, aaro.koskinen@iki.fi, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Jon Hunter <jonathanh@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Miroslav Lichvar <mlichvar@redhat.com>, Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.or
List-Id: linux-omap@vger.kernel.org

On Mon, 25 Jun 2018, John Stultz wrote:
> On Sat, Jun 23, 2018 at 5:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> Thomas, what is wrong with *you*?  This is completely unnecessary.

Nothing is wrong with me. I just hit a point where the amount of half baken
crap tripped me over the edge and I let of steam. Sorry for that, it surely
wasn't necessary. It was one of those days where grumpiness took
control. My steam pressure is back to normal and I'm more than happy to put
that back on the pure technical level.

To be clear, that rant was not a shot at Baolin. It was definitely
addressed to the people behind him who set him on this project and then
failed to do any sanity checking.

> Now, I've also been quite a poor maintainer of late, and haven't done
> much to help with pre-review of Baloin's code.  So that's on me, not
> him.

Fair enough.

> I was really lucky to have your guidance and support when I was
> starting in the community. Your helping bring me up as a co-maintainer
> (only a a relatively small set of responsibility compared to your much
> wider maintainership), does let me see that having the responsibility
> of billions of devices running your code is immense and comes with no
> small amount of stress. Juggling the infinite incoming stream of
> review requests on naieve or otherwise lacking code with other
> important development priorities is a major burden, so *I really get
> how frustrating it is*.

Yes, and I have to admit that I'm not a super human and despite trying to
control my emotions, there are points where I fail in doing so. It makes me
explode and that's it. I can assure Baolin, that this is nothing which
sticks. I'll look at the next patchset from a pure technical level. There
are surely precautions, but definitely no prejudice.

> And its super annoying to have lots of short-term development requests
> being thrown at you when you're the one who has to maintain it for the
> long term.  But long-long-term, no one is going to be a maintainer
> forever, and we are not going to develop more olympic swimmers if we
> keep peeing in the pool.

Right, that's why I early looked for co/sub-maintainers, but as you
admitted yourself, that's not always working out and I surely would
appreciate if there would be more help on all ends. I'm the last person who
rejects help, quite the contrary I'm very happy when I can mark mails as
'none of my business, somebody else takes care of that'.

Thanks,

	tglx
