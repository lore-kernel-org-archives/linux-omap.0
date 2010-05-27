From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 22:28:52 +0100
Message-ID: <20100527212852.GA9859@srcf.ucam.org>
References: <20100527210808.GB8865@srcf.ucam.org> <Pine.LNX.4.44L0.1005271723200.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005271723200.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 27, 2010 at 05:24:28PM -0400, Alan Stern wrote:

> Would it help to divide the application into two processes, one of 
> which receives events and the other does the drawing?

At the point where you're rewriting the application you can just make it 
adhere to our current behavioural standards anyway.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
