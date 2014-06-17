From: Tom Rini <trini-l0cyMroinI0@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for
 BeagleBoard.org boards
Date: Tue, 17 Jun 2014 10:58:24 -0400
Message-ID: <53A05790.7090803@ti.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk> <53A03675.1000908@ti.com> <20140617125640.GC3705@n2100.arm.linux.org.uk>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <beagleboard+bncBCF77LUSWAKRBG5PQGOQKGQEOYYBXKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140617125640.GC3705-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/17/2014 08:56 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 17, 2014 at 08:37:09AM -0400, Tom Rini wrote:
>> On 06/17/2014 05:09 AM, Russell King - ARM Linux wrote:
>>> A good way that this could have been done is to put an I2C EEPROM on
>>> each cape, and have that store the DT fragment.  The boot loader could
>>> have then read that from each cape, and used that information to build
>>> up the final DT.  Why this hasn't been thought of, considering that the
>>> kernel has been moving towards DT for years, is quite unbelievable.
>>
>> I had actually talked about this a long while back (face to face) with
>> people, but the problem was (and still kind of is) the bindings
>> changing, etc.
> 
> And that's a strong argument for having stable bindings - or at the
> very least, ensuring that new bindings which are compatible with older
> versions.

Yes.  This was a few years back (a bit before the first beaglebone was
public) so before we had really pushed up on some level of binding
stability.

-- 
Tom

-- 
For more options, visit http://beagleboard.org/discuss
--- 
You received this message because you are subscribed to the Google Groups "BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
