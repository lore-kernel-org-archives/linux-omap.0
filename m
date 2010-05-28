From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 12:41:23 +0100
Message-ID: <20100528114123.GA22947@srcf.ucam.org>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk> <Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org> <20100527230806.4deb6de3@lxorguk.ukuu.org.uk> <20100527220949.GB10602@srcf.ucam.org> <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk> <20100527223605.GB11364@srcf.ucam.org> <20100527235546.09f3ce8a@lxorguk.ukuu.org.uk> <20100528043114.GC26177@thunk.org> <20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tytso@mit.edu, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 28, 2010 at 10:37:13AM +0100, Alan Cox wrote:

> The other vendors appear to be managing nicely without magic blockers. I
> conjecture therefore there are other solutions.

Actually, no. A badly behaved application will kill the N900's battery 
life. Nobody else has "managed nicely" - they've just made life harder 
for application developers and users, which may have something to do 
with the relative levels of market adoption of Maemo and Android. I'm 
not aware of any form of resource management framework in MeeGo either, 
so as far as I know it'll have exactly the same problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
