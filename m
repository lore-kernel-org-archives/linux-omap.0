From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:36:26 +0200
Message-ID: <201005272336.26643.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271329460.3239-100000@iolanthe.rowland.org> <1274981871.27810.5650.camel@twins>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274981871.27810.5650.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thursday 27 May 2010, Peter Zijlstra wrote:
> On Thu, 2010-05-27 at 13:32 -0400, Alan Stern wrote:
> 
> > On some platforms (like those with ACPI), deeper power-savings are
> > available by using forced suspend than by using idle. 
> 
> Sounds like something that's fixable, doesn't it?

The fix would probably have to involve rewriting the ACPI spec.

Rafael
