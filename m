From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 19:12:21 +0200
Message-ID: <1275066741.20005.127.camel@thorin>
References: <20100527210808.GB8865@srcf.ucam.org>
	 <Pine.LNX.4.44L0.1005271723200.3239-100000@iolanthe.rowland.org>
	 <20100527212852.GA9859@srcf.ucam.org> <1275040988.20005.29.camel@thorin>
	 <20100528114504.GB22947@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100528114504.GB22947@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fre, 2010-05-28 at 12:45 +0100, Matthew Garrett wrote:
> On Fri, May 28, 2010 at 12:03:08PM +0200, Bernd Petrovitsch wrote:
> > On Don, 2010-05-27 at 22:28 +0100, Matthew Garrett wrote:
> > > At the point where you're rewriting the application you can just make it 
> > > adhere to our current behavioural standards anyway.
> > 
> > Thank you for confirming that the so-called "feature" is just there to
> > make apps work in some area that are crappy anyways - and God knows in
> > which other areas they are crappy too.
> 
> Kind of like memory protection, really. Or preemptive multitasking. Or 
> many things that the kernel does to prevent badly written applications 
> from interfering with other applications or the user's experience.

With the main difference that their semantics and API is defined by the
lower layer so that the lower layer can make useful - for the
multitasking part - scheduling decisions.
There were other forms of multitasking before preemptive multitasking -
coroutines (e.g. in Win-3.x quite late in IT history) and the like.
So why not simply skip one step in evolution and go more directly to a
useful solution?

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
