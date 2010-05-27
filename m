From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 19:20:56 +0100
Message-ID: <20100527192056.6fd32c1d@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<1274982779.27810.5708.camel@twins>
	<20100527175719.GD3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527175719.GD3543@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010 18:57:19 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 27, 2010 at 07:52:59PM +0200, Peter Zijlstra wrote:
> 
> > Shall we henceforth stop confusing forced suspend for laptops and
> > powersaving a running system?
> 
> If you want to support forced suspend for laptops and you want to avoid 
> the risk of losing wakeups then you need in-kernel suspend blockers.

It isn't suspend blockers or nothing. Look at the bigger picture.
