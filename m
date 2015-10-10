From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Date: Sat, 10 Oct 2015 01:42:47 +0100
Message-ID: <yw1xzizrh7ug.fsf@unicorn.mansr.com>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
	<20151009232015.GC32536@n2100.arm.linux.org.uk>
	<yw1x4mhzioxl.fsf@unicorn.mansr.com>
	<20151009235441.GD32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009235441.GD32536@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 10 Oct 2015 00:54:41 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-cris-kernel@axis.com, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Oct 10, 2015 at 12:48:22AM +0100, M=E5ns Rullg=E5rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>=20
>> > On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
>> >> This passes a data pointer specified in the sched_clock_register(=
)
>> >> call to the read callback allowing simpler implementations thereo=
f.
>> >>=20
>> >> In this patch, existing uses of this interface are simply updated
>> >> with a null pointer.
>> >
>> > This is a bad description.  It tells us what the patch is doing,
>> > (which we can see by reading the patch) but not _why_.  Please inc=
lude
>> > information on why the change is necessary - describe what you are
>> > trying to achieve.
>>=20
>> Currently most of the callbacks use a global variable to store the
>> address of a counter register.  This has several downsides:
>>=20
>> - Loading the address of a global variable can be more expensive tha=
n
>>   keeping a pointer next to the function pointer.
>>=20
>> - It makes it impossible to have multiple instances of a driver call
>>   sched_clock_register() since the caller can't know which clock wil=
l
>>   win in the end.
>>=20
>> - Many of the existing callbacks are practically identical and could=
 be
>>   replaced with a common generic function if it had a pointer argume=
nt.
>>=20
>> If I've missed something that makes this a stupid idea, please tell.
>
> So my next question is whether you intend to pass an iomem pointer
> through this, or a some kind of structure, or both.  It matters,
> because iomem pointers have a __iomem attribute to keep sparse
> happy.  Having to force that attribute on and off pointers is frowned
> upon, as it defeats the purpose of the sparse static checker.

So this is an instance where tools like sparse get in the way of doing
the simplest, most efficient, and obviously correct thing.  Who wins in
such cases?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
