From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next caused by 95026658c46e i2c: do not use
 internal..
Date: Mon, 14 Mar 2016 10:26:56 -0700
Message-ID: <20160314172656.GH9329@atomide.com>
References: <20160314160944.GG9329@atomide.com> <20160314165206.GA16371@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160314165206.GA16371@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Wolfram Sang <wsa@the-dreams.de> [160314 09:52]:
> Hi,
> 
> > Having something like this happen just as the merge window opens is
> > not nice. You guys should already know..
> 
> I already applied the fix.

OK great thanks!

> > The patches in next should be sitting there for a few weeks before the
> > merge window so issues like this are found out early.
> 
> I understand this was a major hickup and I am sorry for this. I should
> have known better.

Thanks for understanding my suffering :) I've been chasing various
regressions constantly over past months..  So I've started to keep my
eye on Linux next hoping to prevent being stuck chasing regressions
forever..

> I am not taking 100% of the blame, though: The amount of submissions is
> rising faster than the amount of non-maintainer review being done (at
> least in the subsystems I work on). I took a wrong step in trying to
> handle the gap. I am really sorry about the fuzz, yet I can't deny there
> is also something inevitable in that to me. That being said, I'll of
> course try harder to not let this happen again.

Yeah the same applies to may subsystems for sure. Probably a good idea
to be extra careful about not causing regressions with core subsystem
changes.

Regards,

Tony
