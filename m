From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for sharing with other platforms
Date: Thu, 07 Apr 2011 17:38:38 -0700
Message-ID: <87vcyp37ch.fsf@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<20110407165654.GD8052@linux-sh.org> <8739lu9eg6.fsf@ti.com>
	<201104080035.26989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104080035.26989.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 8 Apr 2011 00:35:26 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday, April 07, 2011, Kevin Hilman wrote:
>> Paul Mundt <lethal@linux-sh.org> writes:
>> 
>> > On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
>> >> There is really nothing SH-mobile specific about this runtime PM
>> >> implementation.  Any platform wanting to implement runtime PM based on
>> >> simple clock gating can use this implementation.
>> >> 
>> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> >
>> > This observation is wholly architecture agnostic, so it's not clear that
>> > keeping it in arch/arm/common is any better. It seems that this would be
>> > better suited for drivers/base/power/ with a generic Kconfig symbol.
>> 
>> Sounds fine to me.
>
> Well, what platforms is the clock framework available on?

Well, the majority of implementations of <linux/clk.h> are certainly in
ARM, but I know it's also implemented for SH, and a quick grep shows
implementations in powerpc, mips and m68k also.

Kevin
