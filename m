From: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for
 BeagleBoard.org boards
Date: Tue, 17 Jun 2014 12:33:01 -0400
Message-ID: <CA+T6QP=wShk2pT+znmucF54qseF78MewYaY09UR0qsHv26eVWA@mail.gmail.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
	<CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
	<20140617090931.GB3705@n2100.arm.linux.org.uk>
	<20140617125831.GI4173@beef>
	<20140617131522.GD3705@n2100.arm.linux.org.uk>
	<C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com>
	<20140617160119.GE3705@n2100.arm.linux.org.uk>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <beagleboard+bncBDELZWNUYMHBBPO3QGOQKGQEJ76QVVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140617160119.GE3705-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 17, 2014 at 12:01 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Tue, Jun 17, 2014 at 04:32:11PM +0300, Pantelis Antoniou wrote:
>> The complexity is absolutely required, and it has nothing to do with
>> beaglebone capes.
>>
>> The fact of the matter is that reconfigurable hardware is here, on
>> shipping system, and we, as the linux kernel community have to make
>> sure it works, and that it works in a sane way.
>
> Right, so looking back in the git history, this project has been going
> on for... at least four years?  Probably longer than the length of time
> that we've been converting ARM to DT.  At no point during that has anyone
> brought up the issue of DT being dynamic, so none of the drivers which
> we have been converting caters for this.
>
> Isn't this a bit of a missed opportunity, if this is a direction that
> OF wishes to head towards?

I believe it absolutely is a missed opportunity, but that doesn't mean
it isn't still needed moving forward. We've been using overlays
successfully in the BeagleBoard.org community on BeagleBone Black for
over a year now. It is just a shame we're still shipping a 3.8 kernel.
This universal overlay provides hope to support most add-ons, but it
doesn't address the dynamic nature of some add-on hardware. It is
certainly my hope that this effort doesn't derail the overlay
development work.

>
> Wouldn't it have been relevant to the discussion at kernel summit too,
> concerning DRM/v4l2/componentised systems?  What if someone comes along
> tomorrow with part of their multimedia based system inside a FPGA
> which they program up at runtime?
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.

-- 
For more options, visit http://beagleboard.org/discuss
--- 
You received this message because you are subscribed to the Google Groups "BeagleBoard" group.
To unsubscribe from this group and stop receiving emails from it, send an email to beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
