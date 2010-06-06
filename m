From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Sun, 6 Jun 2010 17:43:26 +0100
Message-ID: <20100606164326.GA12570@srcf.ucam.org>
References: <AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com> <AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com> <AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com> <AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com> <AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com> <AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com> <20100606133130.GA8513@srcf.ucam.org> <AANLkTimXTgZS_fZQa8hjIptJrCn756gF_xakT1IQiLWa@mail.gmail.com> <20100606152946.GA11351@srcf.ucam.org> <AANLkTilOq_5yUW1AIMH1qSE699gyRUTlzGPUVc4CrReY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilOq_5yUW1AIMH1qSE699gyRUTlzGPUVc4CrReY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Brian Swetland <swetland@google.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 06, 2010 at 05:47:10PM +0200, Vitaly Wool wrote:
> 2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
> > The difference between idle-based suspend and opportunistic suspend is
> > that the former will continue to wake up for timers and will never be
> > entered if something is using CPU, whereas the latter will be entered
> > whenever no suspend blocks are held. The problem with opportunistic
> > suspend is that you might make the decision to suspend simultaneusly
> > with a wakeup event being received. Suspend blocks facilitate
> > synchronisation between the kernel and userspace to ensure that all such
> > events have been consumed and handld appropriately.
> 
> Right, and then you start taking suspend blockers in kernel here and
> there which eventually interferes with runtime PM.

Suspend blocks prevent system suspend, not any per-device suspend.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
