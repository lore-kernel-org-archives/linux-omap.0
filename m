From: david@lang.hm
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 01:23:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1006060121180.17462@asgard.lang.hm>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu> <20100603232302.GA16184@elte.hu> <alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org> <20100603234634.GA21831@elte.hu> <alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
 <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 3 Jun 2010, Linus Torvalds wrote:

> On Thu, 3 Jun 2010, Linus Torvalds wrote:
>>
>> so I'd like to see the opportunistc suspend thing think about CPU
>> offlining
>
> Side note: one reason for me being somewhat interested in the CPU
> offlining is that I think the Android kind of opportunistic suspend is
> _not_ likely something I'd like to see on a desktop. But an the
> "opportunistic CPU offliner"? That might _well_ be useful even outside of
> any other suspend activity.

When the OLPC was first released there was talk that the hardware was well 
designed for sleeping (including the ability for the display to keep going 
even if the system itself shut down), with the idealistic talk of the 
system possibly sleeping between keystrokes.

things didn't end up working (a couple pieces of hardware ended up not 
playing well with others), but the concept is still something that could 
end up impacting users outside of the mobile phone market, even if not on 
your traditional desktop.

David Lang
