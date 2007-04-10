From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Pending March patches -- OMAP DPSGW code migration
Date: Wed, 11 Apr 2007 04:56:48 +0900
Message-ID: <20070410195648.GA19808@linux-sh.org>
References: <20070404130449.GB29129@atomide.com>
	<20070404.171005.129442185.Hiroshi.DOYU@nokia.com>
	<20070404143651.GD29129@atomide.com>
	<20070410.103625.110115446.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070410.103625.110115446.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com, Toshihiro.Kobayashi@nokia.com, Komal.shah802003@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 10, 2007 at 10:36:25AM +0300, Hiroshi DOYU wrote:
> > OK. I'll drop the "ARM: OMAP: Add DSP common code" patch from
> > omap-upstream for now. Then we can put together the minimal DSP init
> > patch later on for 2.6.23 or something. The omap-upstream queue is
> > already painfully big :)
> >
> > What do you think we should keep in plat-omap?
> >
> > Maybe just something to power up and idle the DSP, and allow using McBSP
> > for audio?
> 
> Yes, it may be like that.
> 
It's probably worth pushing the MMU framework bits also, since it will
also be required for things like the camera MMU. Though it's not worth
pushing infrastructure if there are no in-tree users.

> Now there are some H/W combinations coming, like ARM+IVA1, ARM?+IVA2,
> , OMAP730, ARM?+?. Also there exists TI's S/W bridge implementation
> and TI's middlewares on the top of that. All of them uses the same
> kind of "interrupt based mailbox", "shared memory" and "MMU control"
> to communicate between MPU and DSP, though their implementations are
> somewhat different. So, now the situation is getting complicated
> because there are the several kind of S/W and H/W combinations.
> 
The other thing to consider also is how generic these sorts of things can
be made. We're in a position now where both spufs and dspgw take very
different approaches to a fairly common problem. Trying to maintain API
or ABI compatability with the old code is likely not worth the trouble in
the long run, particularly as that's not something that has a lot of
chance of being merged upstream.

> For "BASIC S/W COMPONENTS", at least, there may be following modules
> 
>   - OMAP non-MPU MMU FW
>   - MAILBOX
>   - IPC message protocol
>   - Shared memory management
>   - DSP processor management/control

It should be possible to do these generically from an API level at least.

>   - DSP TASK/NODE, STREAM management

This has to be platform specific.

>   - DSP COFF/DOFF loader
> 
And this can mostly be in userspace. Other platforms for instance do use
in-kernel loaders, but generally only for ELF. The MIPS VPEs are an
example of this, albeit for a slightly different usecase.

>   - character device interface "/dev/dsptask?"	(ex: DSPGW)
>   - user defined "ioctl()" messages		(ex: TI's bridge)
>   - DSP specified filesystem, "DSPFS"		(most reasonable one)
>   - userland device driver
>   - nice fancy interfaces?                      (no idea for me, now)
> 
I would like to see a consolidation between dspfs and process context as
per the RidgeRun TaskBridge. Rolling a special library and interfaces
makes little sense for places where regular system calls will suffice
just fine. The SPU libraries end up doing this via pthreads, but I
suppose kernel threads will be required for most of these cases (this is
what TaskBridge did also).

> The above interfaces can be wrapped by userland library API to keep
> the compatibility for the existing middleware interfaces.
> 
That's another problem entirely. Writing userspace wrappers around this
stuff for API compatability is of course an option, but it's not worth
carrying extra weight around on the kernel side to try and accomodate
this sort of thing, especially if there's a better way to do codec
manipulation.
