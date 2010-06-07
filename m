From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 04:00:26 -0400
Message-ID: <20100607080026.GA15851@infradead.org>
References: <1275834706.7227.545.camel@mulgrave.site>
 <alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
 <1275844114.7227.552.camel@mulgrave.site>
 <20100606190525.GA20517@infradead.org>
 <AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
 <20100606192405.GA7559@infradead.org>
 <AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
 <alpine.LFD.2.00.1006070014380.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006070014380.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Swetland <swetland@google.com>, Christoph Hellwig <hch@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Vitaly Wool <vitalywool@gmail.com>, Arve Hj?nnev?g <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 07, 2010 at 12:26:55AM +0200, Thomas Gleixner wrote:
> That takes a lot of the bullshit arguments about downstream users
> being hurt out of the discussion. The above problems are way more
> complex to resolve than the suspend blocker details.
> 
> That's another prove why we can let the drivers flow in (in the worst
> case w/o the suspend blocker stubs) and have no pressure to resolve
> the suspend blocker problem yesterday.
> 
> That said, after thinking more about it, I'm advocating the stubs
> solution with a clear removal / decision date constraint
> (e.g. 2.6.37), as it forces all involved parties to stay tuned and not
> to forget about it. I'm curious about the outcome :)

As long as we have that clear removal schedule I'm fine with in-kernel
suspend blocker stubs.
