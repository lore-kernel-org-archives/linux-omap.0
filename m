From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: Pending March patches -- OMAP DPSGW code migration
Date: Tue, 10 Apr 2007 10:36:25 +0300 (EEST)
Message-ID: <20070410.103625.110115446.Hiroshi.DOYU@nokia.com>
References: <20070404130449.GB29129@atomide.com>
	<20070404.171005.129442185.Hiroshi.DOYU@nokia.com>
	<20070404143651.GD29129@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070404143651.GD29129@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: Toshihiro.Kobayashi@nokia.com, linux-omap-open-source@linux.omap.com, Komal.shah802003@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

> > > What are your thoughts on that? I'm thinking that we could do it few
> > > weeks after 2.6.21 after a stable 2.6.21-omap release.
> >
> > Agreed. It would be cleaner and easy to handle other implementation also.
>
> OK. I'll drop the "ARM: OMAP: Add DSP common code" patch from
> omap-upstream for now. Then we can put together the minimal DSP init
> patch later on for 2.6.23 or something. The omap-upstream queue is
> already painfully big :)
>
> What do you think we should keep in plat-omap?
>
> Maybe just something to power up and idle the DSP, and allow using McBSP
> for audio?

Yes, it may be like that.

I think that it is time to consider DSPGW implementation again to
support multiple bridge implementation and H/W combination at this
transition.

"DSPGW" was originally designed to support just ARM+C55x on OMAP1,
only one combination, then OMAP2 now. It is composed of MPU side
S/W(kernel/userland) and DSP side S/W(including DSP/BIOS).

Now there are some H/W combinations coming, like ARM+IVA1, ARM?+IVA2,
, OMAP730, ARM?+?. Also there exists TI's S/W bridge implementation
and TI's middlewares on the top of that. All of them uses the same
kind of "interrupt based mailbox", "shared memory" and "MMU control"
to communicate between MPU and DSP, though their implementations are
somewhat different. So, now the situation is getting complicated
because there are the several kind of S/W and H/W combinations.

At the point of MPU(ARM) side bridge S/W, it may be better that OMAP
DSP bridge driver provides a collection of "BASIC S/W COMPONENTS" at
first, and then builds up several kind of "USER INTERFACE" on the top
of them, in order to support multiple H/W and S/W combinations,
sharing their code as much as possible.

For "BASIC S/W COMPONENTS", at least, there may be following modules

  - OMAP non-MPU MMU FW
  - MAILBOX
  - IPC message protocol
  - Shared memory management
  - DSP processor management/control
  - DSP TASK/NODE, STREAM management
  - DSP COFF/DOFF loader

Basically each of them should be _independent_ and just provides its
basic feature for their users as APIs, though some of them have to be
stacked as layer.

For "USER INTERFACE", there are/will be some implementations
below. They are just interfaces to make use of/be composed of, some or
all of the above BASIC COMPONENTS. User can choose any interface among
them. In other words, these user interfaces may be exclusive.

  - character device interface "/dev/dsptask?"	(ex: DSPGW)
  - user defined "ioctl()" messages		(ex: TI's bridge)
  - DSP specified filesystem, "DSPFS"		(most reasonable one)
  - userland device driver
  - nice fancy interfaces?                      (no idea for me, now)

The above interfaces can be wrapped by userland library API to keep
the compatibility for the existing middleware interfaces.

Also there may be a trade-off that how much work userland application
take care of. For example, userland application can be something like
just "userland device driver" which just uses "MAILBOX" and "MMU FW"
interfaces to control "DSP". Or most of the work can be done within
kernel module.

So I think that, once the above "BASIC S/W COMPONENTS" are implemented,
it would be easier to implement another interfaces on the top of them,
because an interface can choose some/all of components which it
requires to build their interface/API for users.

Now the problem is current DSPGW's components are a little bit too
related each other to support multiple
combinations/implementations. Along with this DSPGW code migration, we
had better solve this complexity, at least some extent;) to introduce
further/another implementations later.

Any comments would be appreciated.

    Hiroshi DOYU
