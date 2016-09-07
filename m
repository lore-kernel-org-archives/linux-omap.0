From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Kexec regression in next-20160906
Date: Wed, 7 Sep 2016 09:08:07 +0100
Message-ID: <20160907080807.GD5783@n2100.arm.linux.org.uk>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
 <2229914.bQjEFCIRgO@hactar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2229914.bQjEFCIRgO@hactar>
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dave Young <dyoung@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 06, 2016 at 08:33:20PM -0300, Thiago Jung Bauermann wrote:
> Thanks for reporting the problem and finding the commit that caused it.
> The only thing in commit 5c01cdd2d4bc which can affect kexec_load is the 
> fact that struct kexec_segment has a new member.
> 
> This is probably breaking the ABI on ARM, then. I verified that kexec_load 
> kept working on ppc64le with a kexec binary compiled with the original 
> struct kexec_segment definition, but apparently I got lucky.

That _will_ definitely break the ABI on ARM, and pretty much all
32-bit architectures.  It's a silly thing to do, and I'm really
surprised that it passed through review without being spotted.

The reason you "got lucky" with ppc64le is that there was probably
padding in the structure, and you happened to place your new member
in that padding, so the structure size didn't change.

For 32-bit architectures, there will be no padding - both the pointers
and size_t members will be 32-bit, and will be naturally aligned, and
hence there will be no padding.  Any addition to the structure will
change the size of the structure.

Any change to a UAPI header needs to be carefully considered and
questioned as it is always a potential userspace breakage - and in
the kernel, we're supposed to be doing our up-most to avoid
breaking userspace.

It's not like it was in the old days when we didn't have the UAPI
seperate - today, we can find these things by looking at the patch
diffstat and seeing whether any file in "uapi" is touched.  That
should be the trigger for a really in-depth review of the change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
