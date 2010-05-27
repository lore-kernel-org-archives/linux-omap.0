From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:02:13 +0200
Message-ID: <1274983333.27810.5744.camel@twins>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	 <1274982779.27810.5708.camel@twins>  <20100527175719.GD3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527175719.GD3543@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 18:57 +0100, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:52:59PM +0200, Peter Zijlstra wrote:
> 
> > Shall we henceforth stop confusing forced suspend for laptops and
> > powersaving a running system?
> 
> If you want to support forced suspend for laptops and you want to avoid 
> the risk of losing wakeups then you need in-kernel suspend blockers. 
> That's entirely orthogonal to Android's runtime power management.

The simple fact of life is, on PC style hardware suspend is mostly about
missing events. I really _really_ want to miss mouse movement of my
bluetooth mouse when the gear is stowed in my backpack.

Its perfectly OK to miss events on _forced_ suspend.
