From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 12:03:22 -0700
Message-ID: <51266F7A.4080609@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <5125A1FE.5000604@wwwdotorg.org> <5126213E.9010809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <5126213E.9010809@ti.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 06:29 AM, Tom Rini wrote:
> On 02/20/2013 11:26 PM, Stephen Warren wrote:
>> On 02/20/2013 06:37 PM, Joel A Fernandes wrote:
>>> Hello, I've been spinning some work-in-progress patches for
>>> FIT build support in the kernel. With the move to
>>> multiplatform support on OMAP, I feel it is a good time to add
>>> FIT support, also looking at the proliferating number of dtbs,
>>> as it is a nice way
> 
>> To my mind, FIT is pointless. And forcing the kernel build
>> process to create bootloader-specific files doesn't seem like a
>> good idea. Doing so would require pulling in even more outside
>> tools into the kernel build flow.
> 
> No, it requires no more tools than we have today.  It's still just 
> mkimage and a device tree file.

mkimage isn't required today, if you use the bootz target rather than
bootm. Using bootz is a huge improvement since you don't need to use
bootloader-specific tools to create the kernel boot images; just slap
them on the disk, and you're done. Nothing could be simpler.

>> All you need is to copy the zImage and any relevant .dtb files 
>> into /boot, and have U-Boot load the relevant .dtb file by 
>> constructing the filename as roughly ${soc}-${board}.dtb, then
>> use the bootz command to boot it. You can have a completely
>> generic boot.scr (or built-in script).
> 
> Note you still have to copy N dtb files into the filesystem.  Or
> one file, the FIT image.

But you have to generate the FIT image that packages all the files
together.

The long-term goal for device tree is to move the *.dts files out of
the kernel source. It's unclear if there will be some single central
repository for them, or whether vendors will host their own repository
just for their own boards. The latter would probably scale the best.
Having separate distro packages for different vendors' or different
SoCs' device tree would also scale the best; forcing usage of FIT
where everything gets merged together doesn't interact well with that.

>> Note: Not all (many?) U-Boot support FIT anyway, so you'd need
>> to flash a new U-Boot to support FIT, so you may as well just
>> flash a new U-Boot that implements the ${soc} and ${board}
>> variables instead. IIRC, there may also be a ${boardname} or
>> similar that's like ${board}, but represents the runtime-detected
>> board for when one U-Boot build actually supports multiple
>> different boards.
> 
> And enable bootz as well.  Just about as many boards enable that as
> do FIT.  And FIT has been around for years, bootz not so.  So in
> theory folks with old/odd boards that didn't bother to get
> mainlined in U-Boot could still have FIT support added, easily.

I guess that's true, but enabling bootz in a U-Boot ends up bringing
in a lot less conceptual complexity, and I would guess a bit less code
too.
