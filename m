From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 15:39:44 -0700
Message-ID: <AANLkTil0XV8EDK8WWody7f-L5ou4p_a3O_T6dTjWB12C@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<20100605152326.7ccd5160@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100605152326.7ccd5160@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Arjan van de Ven <arjan@infradead.org>:
> On Sat, 5 Jun 2010 14:26:14 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>
>> On Sat, Jun 5, 2010 at 9:28 AM, Arjan van de Ven
>> <arjan@infradead.org> wrote:
>> > On Sat, 05 Jun 2010 11:54:13 +0200
>> > Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> >> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=F8nnev=E5g wrote:
>> >> > > Trusted processes are assumed to be sane and idle when there is
>> >> > > nothing for them to do, allowing the machine to go into deep
>> >> > > idle states.
>> >> > >
>> >> >
>> >> > Neither the kernel nor our trusted user-space code currently
>> >> > meets this criteria.
>> >>
>> >> Then both need fixing. Really, that's the only sane approach.
>> >
>> > fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
>> > without really bad hacks.
>> >
>>
>> We clearly have different standards for what we consider good. We
>> measure time suspended in minutes or hours, not seconds, and waking up
>> every second or two causes a noticeable decrease in battery life on
>> the hardware we have today.
>
> I guess I'm spoiled working with (unreleased) hardware that knows how
> to power gate ;-)
>
>
>>
>> > the kernel has a set of infrastructure already to help here (range
>> > timers, with which you can wakeup-limit untrusted userspace crap),
>> > timer slack for legacy background timers, etc etc.
>>
>> Range timers allows the kernel to align different timers so they don't
>> each bring the cpu out of idle individually. They do not eliminate
>> timers or make individual timers fire less often.
>
> you're incorrect.
> With range timers you can control the rate at which timers fire just
> fine.
>
> For example if the Adobe Flash player puts a timer every 10
> milliseconds (yes it does that), and you give it a 3.99 seconds range,
> it will fire its timers every 4 seconds.... unless other activity
> happens independently, at which point it'll align with that instead.
>

If you do that what you are delivering is nowhere close to what the
app asked for. You don't need range timers for this, you could just as
well add 4 seconds to all normal timers.

-- =

Arve Hj=F8nnev=E5g
