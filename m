From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Wed, 22 Jun 2011 15:05:32 +0200
Message-ID: <201106221505.32531.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com> <201106211620.02065.arnd@arndb.de> <BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

On Wednesday 22 June 2011, Ohad Ben-Cohen wrote:
> > One point I noticed is the use of debugfs, which you should probably
> > replace at some point with a stable API, e.g. your own debugfs-like
> > file system, but there is no hurry to do that now.
> 
> debugfs is only being used to expose debugging info (namely the power
> state of the remote processor and its trace log messages), which is
> mostly useful for developers trying to understand what went wrong.
> 
> It seems like debugfs fits quite nicely here (e.g. it's perfectly fine
> if this is completely compiled out on production systems), but sure,
> we can always revisit this later too.

Ok, I see. In that case I agree that using debugfs is fine, but I would
recommend trying to use fewer macros and just open-coding the file
operations for better readability.

> > Unfortunately require __packed. It would be better to sort the members
> > differently so that each member is naturally aligned in order to
> > avoid the need for padding or __packed attributes
> 
> Definitely. __packed is being used just to be on the safe side; we
> didn't intend to introduce unnatural alignment intentionally. will be
> fixed.

Ok.

	Arnd
