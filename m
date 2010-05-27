From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 00:45:32 +0200
Message-ID: <201005280045.32571.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org> <20100527190515.08be091a@lxorguk.ukuu.org.uk> <20100527181533.GH3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527181533.GH3543@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 May 2010, Matthew Garrett wrote:
> On Thu, May 27, 2010 at 07:05:15PM +0100, Alan Cox wrote:
> 
> > I'd prefer we avoided mixing them up. Everyone seems fairly happy with
> > the current operator ordered suspend behaviour I believe ?
> 
> No. The current mechanism can lose wakeup events.

As long as the operator agrees to lose wakeup events occasionally, which is
the case at least 99% of the time, there's nothing wrong with that IMO.

Rafael
