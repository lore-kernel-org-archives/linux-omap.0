From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Date: Sat, 10 Oct 2015 16:33:36 +0100
Message-ID: <20151010153336.GE32536@n2100.arm.linux.org.uk>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
 <20151009232015.GC32536@n2100.arm.linux.org.uk>
 <yw1x4mhzioxl.fsf@unicorn.mansr.com>
 <20151009235441.GD32536@n2100.arm.linux.org.uk>
 <yw1xzizrh7ug.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <yw1xzizrh7ug.fsf@unicorn.mansr.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-cris-kernel@axis.com, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 10, 2015 at 01:42:47AM +0100, M=E5ns Rullg=E5rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>=20
> > On Sat, Oct 10, 2015 at 12:48:22AM +0100, M=E5ns Rullg=E5rd wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >>=20
> >> > On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> >> >> This passes a data pointer specified in the sched_clock_registe=
r()
> >> >> call to the read callback allowing simpler implementations ther=
eof.
> >> >>=20
> >> >> In this patch, existing uses of this interface are simply updat=
ed
> >> >> with a null pointer.
> >> >
> >> > This is a bad description.  It tells us what the patch is doing,
> >> > (which we can see by reading the patch) but not _why_.  Please i=
nclude
> >> > information on why the change is necessary - describe what you a=
re
> >> > trying to achieve.
> >>=20
> >> Currently most of the callbacks use a global variable to store the
> >> address of a counter register.  This has several downsides:
> >>=20
> >> - Loading the address of a global variable can be more expensive t=
han
> >>   keeping a pointer next to the function pointer.
> >>=20
> >> - It makes it impossible to have multiple instances of a driver ca=
ll
> >>   sched_clock_register() since the caller can't know which clock w=
ill
> >>   win in the end.
> >>=20
> >> - Many of the existing callbacks are practically identical and cou=
ld be
> >>   replaced with a common generic function if it had a pointer argu=
ment.
> >>=20
> >> If I've missed something that makes this a stupid idea, please tel=
l.
> >
> > So my next question is whether you intend to pass an iomem pointer
> > through this, or a some kind of structure, or both.  It matters,
> > because iomem pointers have a __iomem attribute to keep sparse
> > happy.  Having to force that attribute on and off pointers is frown=
ed
> > upon, as it defeats the purpose of the sparse static checker.
>=20
> So this is an instance where tools like sparse get in the way of doin=
g
> the simplest, most efficient, and obviously correct thing.  Who wins =
in
> such cases?

In that case, NAK on the patch.  I don't have time for your stupid game=
s.

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
