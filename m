From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
Date: Fri, 30 Apr 2010 12:20:35 -0400
Message-ID: <4BDB0353.5090800@ti.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>	
	<20100126201239.15382.34792.stgit@baageli.muru.com>
	<1272640022.3051.1534.camel@localhost>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1272640022.3051.1534.camel@localhost>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, DaVinci list <Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

[...]
> To fix both problems, maybe we should just use a fixed memory location
> to pass this temporary data from uncompress to the kernel.  We've had a
> similar problem on DaVinci recently and a proposal has been made (and
> tested) to use memory just below the page tables[3].)

Essentially both of these approaches (internal scratch register and
fixed address) implement a weird back-channel communication scheme
between the decompresser and the debug macros.

A more elegant solution may be as follows:
    - pass machine_arch_type as an argument into addruart.
    - move the uart base lookup logic to addruart using macros similar
      to DEBUG_LL_*, except that these expand to assembly code this
      time.
    - reuse these debug-macros in uncompress.h and implement putc() and
      flush() using addruart(), senduart(), etc.

This way, both the decompresser and the kernel debug macros end up using
machine_arch_type to get to the right debug uart, without resorting to
underhand back-channel tricks.

Any thoughts?

-- Cyril.
