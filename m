From: david@lang.hm
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 04:26:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1006060422520.17462@asgard.lang.hm>
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
	<AANLkTimjtNhtI0CuxYd0wdN_svthC-vl9_a5abDS2yyo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimjtNhtI0CuxYd0wdN_svthC-vl9_a5abDS2yyo@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 6 Jun 2010, Felipe Contreras wrote:

> 2010/6/6 Arjan van de Ven <arjan@infradead.org>:
>> On Sat, 5 Jun 2010 14:26:14 -0700
>> Arve Hj?nnev?g <arve@android.com> wrote:
>>>> the kernel has a set of infrastructure already to help here (range
>>>> timers, with which you can wakeup-limit untrusted userspace crap),
>>>> timer slack for legacy background timers, etc etc.
>>>
>>> Range timers allows the kernel to align different timers so they don't
>>> each bring the cpu out of idle individually. They do not eliminate
>>> timers or make individual timers fire less often.
>>
>> you're incorrect.
>> With range timers you can control the rate at which timers fire just
>> fine.
>
> I was wondering... Currently GLib user-space aligns itself to fire
> burst of work at second boundaries without the need for IPC. But if
> you want to align beyond one second you need multi-process alignment.
> Say, one application says: wake me up between 30s and 1m. And the
> other one says: wake me up between 10m and 20m. They could very well
> align at some point if there was a central process keeping track of
> all the timers.
>
> Does the kernel provide something to solve that problem already?

yes,the kernel will let you say 'wake me in 10m, with a possible delay of 
up to 10 min' and get woken up between 10 and 20 min

this is what was mentioned earlier in the thread where you could take an 
app that tries to do something every .1 second and set the kernel to allow 
the tick to be delayed for up to 3.9 seconds, resulting in a wakeup every 
4 seconds if the system is idle. This has the additional advantage that if 
the system is not idle and other things are causing ticks to take place 
anyway, this app would get more ticks up to the 10/second it's asking for)

David Lang
