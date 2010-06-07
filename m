From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 13:25:53 +0300
Message-ID: <AANLkTinajoKfVD3eBNspiuf1e5jFb2jm-OyHJbcbk4xo@mail.gmail.com>
References: <AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<20100606133130.GA8513@srcf.ucam.org>
	<AANLkTimXTgZS_fZQa8hjIptJrCn756gF_xakT1IQiLWa@mail.gmail.com>
	<20100606152946.GA11351@srcf.ucam.org>
	<AANLkTilOq_5yUW1AIMH1qSE699gyRUTlzGPUVc4CrReY@mail.gmail.com>
	<20100606164326.GA12570@srcf.ucam.org>
	<AANLkTim0JD4V0RTc6CRIADypqYhQo3JYp3dJs0l7g7Ps@mail.gmail.com>
	<20100606173146.GA13432@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100606173146.GA13432@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Vitaly Wool <vitalywool@gmail.com>, Brian Swetland <swetland@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Sun, Jun 06, 2010 at 07:21:49PM +0200, Vitaly Wool wrote:
>> 2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
>>
>> > Suspend blocks prevent system suspend, not any per-device suspend.
>>
>> Can you suspend a device which is holding a wake lock?
>
> Yes. Suspend blocks are orthogonal to runtime PM.

In that sense yes, but as it has been stated before; if Android
user-space concentrates on getting suspend blockers right, then the
timers in user-space will not be aligned correctly, and runtime PM
wouldn't work that great. Moreover, opportunistic suspend takes the
device out of idle. So, as runtime PM gets better, there's a point
where opportunistic suspend makes the situation worst.

So they are _mostly_ orthogonal, but not completely, at least for the
analysis of suspend blockers' usefulness.

-- 
Felipe Contreras
