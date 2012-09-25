From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not
	suspended.
Date: Tue, 25 Sep 2012 12:15:06 +0100
Message-ID: <20120925111506.GO31374@n2100.arm.linux.org.uk>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com> <CAKdam572krJZcayRdJ_AciCUZH3LuzD9yoHenhxrB6j9xDZ6JQ@mail.gmail.com> <20120925083029.GG31374@n2100.arm.linux.org.uk> <20120925083118.GI9137@arwen.pp.htv.fi> <20120925091228.GI31374@n2100.arm.linux.org.uk> <20120925091112.GK9137@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120925091112.GK9137@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, gregkh@linuxfoundation.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 25, 2012 at 12:11:14PM +0300, Felipe Balbi wrote:
> that's most likely, of course. But should we cause a regression to
> beagleboard XM because of that ? Also, if you look into chapter 9 of the
> runtime_pm documentation, starting on line 822 you'll see documentation
> suggests the use of mystruct->is_suspended flag.

BTW, I'll point out a fatal flaw in your justification above.

If you read the entire example, you'll see that the is_suspended flag
is _not_ used to prevent resumes without suspends, but is used as a
flag to control whether the driver processes requests or not.  That's
entirely functionally different from using a "is_suspended" flag in
the way you mention above.

Section 5 is quite clear about the requirements at initialization time
for runtime PM, and nothing in section 9 contradicts that, and the
is_suspended flag in that example has nothing to do with any of this.
