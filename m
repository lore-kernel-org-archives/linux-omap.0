From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time DPLL
	detection
Date: Mon, 22 Oct 2007 10:24:24 +0300
Message-ID: <1193037864.29349.261.camel@localhost.localdomain>
References: <20071019211415.183990583@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071019211415.183990583@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Kevin,
On Fri, 2007-10-19 at 14:14 -0700, ext Kevin Hilman wrote:
> In the clock init code, the DPLL value set by the bootloader is
> queried, but always turns zero due it's parent clock (sys_ck) having
> no default rate.  This results in the improper setting of the default
> PRCM rate-table entry and any queries of virt_prcm_set rate to return 0.
> 
> Following the example of the TI kernel, set the default sys_ck rate to
> 13MHz.  Could then be overridden in board setup code.

There should be an even cleaner way to handle that (but i have no code
to prove that it works =) since the boot rom already does auto-detection
of the oscillator to support serial flashing.

If it is possible to read the detected value then the code can be moved
to arch or even plat.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
