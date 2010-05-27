From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:27:40 +0300
Message-ID: <20100527162740.GA9625@nokia.com>
References: <alpine.LFD.2.00.1005271545190.3032@localhost.localdomain>
 <Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005271053420.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
>If people don't mind, here is a greatly simplified summary of the
>comments and objections I have seen so far on this thread:
>
>	The in-kernel suspend blocker implementation is okay, even
>	beneficial.

I disagree here. I believe expressing that as QoS is much better. Let 
the kernel decide which power state is better as long as I can say I 
need 100us IRQ latency or 100ms wakeup latency.

-- 
balbi

DefectiveByDesign.org
