From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 20:27:12 +0100
Message-ID: <20100527202712.181fd172@lxorguk.ukuu.org.uk>
References: <20100527175719.GD3543@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005271449160.3239-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271449160.3239-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

> Rather than continue going around in circles, let's agree that what the 
> Android people want is a new version of forced suspend -- not a 

I don't think this is true. I think that is the root of the problem.

I don't disagree with the user experience they are trying to create or
the fact something is needed to make it possible (if it turns out we
can't already do it).

Forced suspend is sticking stuff in running state into suspend

Power management models (such as Thomas ARM box) which we know work are
'when nothing is running' into suspend.

So for me the real question on that side of this specific case is 'how
do you make sure those tasks are idle when you need them to be'

QoS ?
Spanking them from user space ?
Drivers enforcing policy elements by blocking tasks ?

Alan
