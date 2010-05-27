From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:18:11 +0200
Message-ID: <1274984291.27810.5802.camel@twins>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	 <1274982779.27810.5708.camel@twins> <20100527175719.GD3543@srcf.ucam.org>
	 <1274983333.27810.5744.camel@twins>  <20100527181433.GG3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527181433.GG3543@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-05-27 at 19:14 +0100, Matthew Garrett wrote:
> If I get a WoL 
> packet in the 0.5 of a second between userspace deciding to suspend and 
> actually doing so, the system shouldn't suspend. 

Please re-read Thomas' description of how a driver should do the state
transition.

So either we get the packet before suspend, and we cancel the suspend,
or we get it after and we wake up. What's the problem, and how does that
need suspend blockers?
