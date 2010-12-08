From: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	withCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 11:56:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012081154310.10437@xanadu.home>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
	<AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
	<AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
	<AANLkTin4oiDGqMJqjYO+5pCM4MffiGiTEKW5WxXx9gfg@mail.gmail.com>
	<alpine.LFD.2.00.1012071412260.10437@xanadu.home>
	<AANLkTikVHOgujYh+28TFJDQbHx=AXT_5354bTy9+FLVR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1494612790-1291827422=:10437"
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <AANLkTikVHOgujYh+28TFJDQbHx=AXT_5354bTy9+FLVR-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1494612790-1291827422=:10437
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 8 Dec 2010, Dave Martin wrote:

> Hi,
> 
> On Tue, Dec 7, 2010 at 7:15 PM, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, 7 Dec 2010, Dave Martin wrote:
> >
> >> On Tue, Dec 7, 2010 at 2:53 PM, Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >> [...]
> >> > Note that converting to C doesn't mean that code which attempts to
> >> > copy function bodies will work: you still need to handle the fact that
> >> > if f() is a C function symbol, then the value of the symbol f is
> >> > actually the function's base address + 1.  See my changes in sram.c,
> >>
> >> To clarify, this applies *if* f is a Thumb symbol.
> >
> > To make it generic, a new macro could be used:
> >
> > #define SYM_ADDR(x) ((void *)((long)(x) & ~1L))
> 
> Could do ... I wasn't sure if it was useful for just this one case,
> but I guess we may encounter others.  And it would make the code a lot
> less messy...

That also makes the code self documenting.

> if so, a macro for exracting just the Thumb bit, and a macro for
> rebasing a symbol while preserving the Thumb bit could also be useful.
> 
> #define SYM_STATE(x) ((long)(x) & 1)
> #define SYM_REBASE(new_addr, sym) ((void *)((long)SYM_ADDR(new_addr) |
> SYM_STATE(sym)))
> 
> The relationship could be a bit clearer if we use the name SYM_BASE
> instead of SYM_ADDR.
> 
> With these, the affected code becomes something like:
> 
> memcpy(buffer, SYM_BASE(f), size_of_f);
> new_f = SYM_REBASE(f, buffer);
> 
> What do you think?

Looks fine to me.

> Is there a recommended type for a pointer-sized integer?  I notice
> linux/types.h defines uintptr_t (as unsigned long).

If uintptr_t is already defined then it is probably a good idea to just 
use it.


Nicolas
--8323328-1494612790-1291827422=:10437
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--8323328-1494612790-1291827422=:10437--
