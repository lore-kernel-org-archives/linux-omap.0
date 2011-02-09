From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Wed, 9 Feb 2011 11:07:54 +0100
Message-ID: <201102091107.54917.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081642.52774.arnd@arndb.de>
	<AANLkTimDTVypBFCoO9G72TzKToAThdXm_aEi56O+w9nY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTimDTVypBFCoO9G72TzKToAThdXm_aEi56O+w9nY@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 February 2011, Dave Martin wrote:
> I have a (possibly silly) question ... are the definitions in
> arm/system.h intended to be fully generic, or not?  Some features
> suggest an attempt at genericness, but not everything there is
> generic.  Maybe I have misconstrued the purpose of this header.

asm/system.h contains an ill-defined set of random stuff derived
from what used to be in there in the old days Linux-1.x and
whatever the individual architectures added to it.

There have been previous attempts to reduce the common stuff
and leave only architecture-specific definitions in there, but
it still contains for all architectures at least:

* switch_to()
* mb() and friends
* cmpxchg() and friends

These are hard to change, because each architecture has slightly
different rules for recursive header file inclusion, so you end
up breaking stuff when you touch them.

The other declarations and macros are arch specific, so we could
move them to a different place or change them if there is a good
reason to do that.

I personally think it would be good to have at least cmpxchg and
everything related to it in a separate header, like a few
architectures do (x86, sh, alpha, mips), but I don't see too
much value in doing that just on ARM while leaving the other
architectures alone.

	Arnd
