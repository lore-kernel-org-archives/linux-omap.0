From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Thu, 18 Jan 2018 17:13:14 +1100
Message-ID: <20180118061314.GG3286@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <E7ECBBB8-2E88-4F04-AFC3-659332E84CF6@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E7ECBBB8-2E88-4F04-AFC3-659332E84CF6@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, Andreas Kemnade <andreas@kemnade.info>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Kevin Hilman <khilman@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:59PM +0100, H. Nikolaus Schaller wrote:
> Hi Johan,
> 
> > Am 12.01.2018 um 16:39 schrieb Johan Hovold <johan@kernel.org>:
> > 
> >> Let's restart this discussion and focus on the main roadblock (others
> >> are minor details which can be sorted out later).
> >> 
> >> If it feels like a hack, the key issue seems to me to be the choice of
> >> the API to present the GPS data to user space. Right?
> > 
> > Or even more fundamentally, does this belong in the kernel at all?
> 
> Yes, that can be questioned of course. It was questioned and discussed
> several times and I thought the answer was a clear yes. But let's reiterate.
> 
> > Also it seems at least part of your specific problem is that you have
> > failed to wire up the WAKEUP pin of the W2SG0004/84 properly,
> 
> The w2sg0004 has no wakeup pin. At least I can't find one in the data sheet.

I should have said w2sg0084 above, which is the only datasheet I have found.

> The two pins you refer to from the 0084 data sheet are called BootSelect0/1
> in the 0004 and have a different function.
> 
> To be clear, we did not fail to wire it up. We did the design before the
> 0084 was announced and available. We just had to swap in the 0084 into
> existing PCBs during production because the 0004 became EOL. Otherwise
> we would probably still use the 0004 without WAKEUP output.
> 
> To make it worse, we have no documentation for an individual board if
> an 0004 or 0084 chip is installed and there is no means how a software
> can find out which one it is talking to (especially before properly
> powering on). Therefore we can not even provide two different device
> trees or drivers or whatever, unless we ask people to open their device
> and look on the chip. Quite crazy wrt. user-friendlyness of software
> installation in 2018...
> 
> Therefore, a driver must be capable to handle both chips in the same way,
> with minimalistic assumptions, even if the 0084 could provide a direct
> signal to make it easier than using serdev to monitor the data stream.

Fair enough.

> >  which then
> > forces you to look at the data stream to determine the power state of
> > the chip. Judging from a quick look at the GTA04 schematics it seems
> > you've even connected the WAKEUP output to the 1V8_OUT output?!
> 
> No. You failed to see that this is an optional 0R, which is not installed.
> The 0R on pin 7 (BootSelect1) to GND was removed when we did switch from
> 0004 to 0084. Pin 6 (BootSelect0/WAKEUP) was never connected.

Ok.

> > The kernel is probably not the place to be working around issues like
> > that,

> > even if serdev at least allows for such hacks to be fairly
> > isolated in drivers (unlike some of the earlier proposals touching core
> > code).
> 
> Please tell me why there are so many hacks for hardware issues in certain
> drivers. Any why those are good and this one (if it is one at all) is not.

Hacks are never good, but sometimes needed. But we should try to keep
them contained in drivers rather than allow them to spread to core code,
was what I was trying to say above.

> What I can learn from your discussion is that it might be considerable
> to add an optional gpio for the 0084 WAKEUP and add some logic to
> support users who have or will have that pin connected.
> 
> But even then we would need a driver to handle this gpio and issue
> an on/off impulse on the other to switch states. It would be a different
> driver (variant - maybe some CONFIG option or handled by code), but not
> "no driver".

Having a WAKEUP signal would allow for a more straight-forward
implementation, be it in the kernel or in user space.

> >> I see three reasonable options how this presentation can be done:
> >> 
> >> 1. char device
> >> 2. tty device
> >> 3. some new gps interface API (similar to network, bluetooth interfaces)
> >> 4. no driver and use the UART tty directly
> >> 
> >> Pros and cons:
> > 
> >> 4. no driver and use UART directly
> >> + a non-solution seems to be attractive
> >> - must turn on/off chip by gpio hacks from user-space
> > 
> > I'm not sure that would amount to more of hack then doing it in the
> > kernel would.
> 
> It might not be big effort in the user-space code/scripts.
> 
> But much effort to convince all the plethora of user-space client maintainers
> to integrate something. And have them roll out. And have distributions take it.
> And have users upgrade to it. 5 years later...
> 
> Do you think it is easier to convince them than you? They usually assume a
> power management issue should be solved by the kernel driver.
> 
> That is what Andreas did remark as motivation: provide a solution
> for *existing* user spaces.

I understand that this is what you want, but that in itself is not a
sufficient reason to put something in the kernel.

> >> - can not guarantee (!) to power off the chip if the last user-space
> >> process using it is killed (which is essential for power-management of
> >> a handheld, battery operated device)
> > 
> > That depends on how you implement things (extending gpsd, wrapper
> > script, pty daemon, ...).
> 
> No. You can of course cover all standard cases but there is one fundamental
> issue which is IMHO a problem of any user-space implementation:
> 
> 	How can you guarantee that the chip is powered off if no
> 	user-space process is using it or if the last process doing
> 	this is killed by *whatever* reason?
> 
> E.g. after a kill -9. Or if someone deinstalls gpsd or whatever and assumes
> (and wants a guarantee) that GPS is now turned off and never turned on drawing
> precious milliamps from the battery for no use.

Have something run at init to put the device in a low power state.

> As it is well known, a user-space process can't protect itself against kill -9.
> Or has this recently been changed and I am not aware of?
> 
> This is the fundamental reason why we need a kernel driver to provide
> reliable, repeatable and trustable power management of this chip.
> 
> It is equally fundamental as a hard disk should spin down after the last
> file is closed. Even if this process ends by a kill -9.
> 
> A second almost equally fundamental aspect to be considered is how you want
> to automatically and reliably turn off the chip by pure user-space code when
> entering suspend.

Suspend is initiated by user space, so just power down the device before
doing so.

> >> If not, I want to suggest to accept the second-best choice 2. for now and we
> >> will update the driver as soon as 3. appears. IMHO it would be a good test case
> >> for a new subsystem.
> > 
> > Getting the interface right from the start is quite important, as
> > otherwise we may end up having to support a superseded one for a long
> > time.
> 
> This seems to contradict your argument that user-space can very easily
> adapt to everything. If the latter were true there would be no need to
> keep old interfaces supported for a long time.

You probably know that we try hard never to change an interface that
would break user space, and that's why we need to get it right.

> So can you agree to that a battery powered portable device must have
> reliable and trustable power management? And if it provable can't be
> implemented in user-space (a single counter example suffices) it must
> be a kernel driver?

Having a kernel driver would make things easier for user space, sure,
but again, that's not a sufficient reason to merge just any kernel
implementation.

Johan
