From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Date: Sat, 10 Oct 2015 00:48:22 +0100
Message-ID: <yw1x4mhzioxl.fsf@unicorn.mansr.com>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
	<20151009232015.GC32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151009232015.GC32536-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org> (Russell King's
	message of "Sat, 10 Oct 2015 00:20:15 +0100")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> writes:

> On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
>> This passes a data pointer specified in the sched_clock_register()
>> call to the read callback allowing simpler implementations thereof.
>>=20
>> In this patch, existing uses of this interface are simply updated
>> with a null pointer.
>
> This is a bad description.  It tells us what the patch is doing,
> (which we can see by reading the patch) but not _why_.  Please includ=
e
> information on why the change is necessary - describe what you are
> trying to achieve.

Currently most of the callbacks use a global variable to store the
address of a counter register.  This has several downsides:

- Loading the address of a global variable can be more expensive than
  keeping a pointer next to the function pointer.

- It makes it impossible to have multiple instances of a driver call
  sched_clock_register() since the caller can't know which clock will
  win in the end.

- Many of the existing callbacks are practically identical and could be
  replaced with a common generic function if it had a pointer argument.

If I've missed something that makes this a stupid idea, please tell.

--=20
M=E5ns Rullg=E5rd
mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org
