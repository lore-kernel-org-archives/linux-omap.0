From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 01:15:25 -0600
Message-ID: <CAD=GYpZM7uOHqhwhxzokV161WFZ2azh1VpSBn498PmPZm+bYbQ@mail.gmail.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
	<5125A1FE.5000604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <5125A1FE.5000604@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, "Rini, Tom" <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 20, 2013 at 10:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/20/2013 06:37 PM, Joel A Fernandes wrote:
>> Hello,
>> I've been spinning some work-in-progress patches for FIT build support
>> in the kernel.
>> With the move to multiplatform support on OMAP, I feel it is a good
>> time to add  FIT support, also looking at the proliferating number of
>> dtbs, as it is a nice way
>
> To my mind, FIT is pointless. And forcing the kernel build process to

I don't think so, there are many usecases for FIT and cleanly
embedding DTBs is a common usecase, (along with stronger checksums,
compression). That is also the basis of my ELC talk tomorrow morning
;-)
You could peruse the slides at, http://wwwelinux.org/Fit-boot to get a
better understanding of what FIT solves. With the move to
multiplatform kernels, it is quite a logical next step to add this
support to the kernel build.

> create bootloader-specific files doesn't seem like a good idea. Doing so
> would require pulling in even more outside tools into the kernel build flow.

As for pulling additional tools, dtc is already a part of the kernel
so the idea is to use existing tools.

> All you need is to copy the zImage and any relevant .dtb files into
> /boot, and have U-Boot load the relevant .dtb file by constructing the
> filename as roughly ${soc}-${board}.dtb, then use the bootz command to
> boot it. You can have a completely generic boot.scr (or built-in script).

FIT doesnt need any such bootloader variables and thus benefits from
the simplicity.

> Note: Not all (many?) U-Boot support FIT anyway, so you'd need to flash

For these boards, we can special case to doing a non-fit boot to keep
them backward-compatibility. I don't think maintaining
backward-compatibility requires any additional work, but just building
the kernel with a different make target.

Regards,
Joel
