From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: Kexec regression in next-20160906
Date: Thu, 08 Sep 2016 12:23:13 -0300
Message-ID: <8729269.3rIvqbaU1r@hactar>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com> <2229914.bQjEFCIRgO@hactar> <20160907080807.GD5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160907080807.GD5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dave Young <dyoung@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Am Mittwoch, 07 September 2016, 09:08:07 schrieb Russell King - ARM Linux:
> Any change to a UAPI header needs to be carefully considered and
> questioned as it is always a potential userspace breakage - and in
> the kernel, we're supposed to be doing our up-most to avoid
> breaking userspace.
> 
> It's not like it was in the old days when we didn't have the UAPI
> seperate - today, we can find these things by looking at the patch
> diffstat and seeing whether any file in "uapi" is touched.  That
> should be the trigger for a really in-depth review of the change.

No UAPI header is touched by this patch series. That is because there are 
two definitions of struct kexec_segment, one in include/linux/kexec.h and 
the other one in include/uapi/linux/kexec.h. My patch changed the former.
I was unaware of the second definition in the latter.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
