From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to dts
Date: Tue, 28 May 2019 17:20:25 +0200
Message-ID: <BA6E7BE4-E87A-4B0A-A027-BEA7A9ACA670@goldelico.com>
References: <20190510194229.20628-1-aford173@gmail.com> <af325707-3e42-493d-e858-77878ef06138@ti.com> <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 28.05.2019 um 17:09 schrieb Adam Ford <aford173@gmail.com>:
> 
> On Tue, May 28, 2019 at 4:11 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> 
>> Hi,
>> 
>> On 10/05/2019 22:42, Adam Ford wrote:
>>> Currently the source code is compiled using hard-coded values
>>> from CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK.  This patch allows this
>>> clock divider value to be moved to the device tree and be changed
>>> without having to recompile the kernel.
>>> 
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> 
>> I understand why you want to do this, but I'm not sure it's a good idea.
>> It's really something the driver should figure out, and if we add it to
>> the DT, it effectively becomes an ABI.
>> 
>> That said... I'm not sure how good of a job the driver could ever do, as
>> it can't know the future scaling needs of the userspace at the time it
>> is configuring the clock. And so, I'm not nacking this patch, but I
>> don't feel very good about this patch...
>> 
>> The setting also affects all outputs (exluding venc), which may not be
>> what the user wants. Then again, I think this setting is really only
>> needed on OMAP2 & 3, which have only a single output. But that's the
>> same with the current kconfig option, of course.
>> 
>> So, the current CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is an ugly hack, in my
>> opinion, and moving it to DT makes it a worse hack =). But I don't have
>> any good suggestions either.
> 
> As it stands the Logic PD OMAP35 and AM37/DM37 boards (SOM-LV and
> Torpedo) require this to be hard coded to 4 or it hangs during start.
> This is the case for all versions 4.2+.  I haven't tested it with
> older stuff.  Tony has a DM3730 Torpedo kit and reported the hanging
> issue to me. I told him to set that value to 4 to make it not hang.
> He asked that I move it to the DT to avoid custom kernels.  I agree
> it's a hack, but if it's create a customized defconfig file for 4
> boards or modify the device tree, it seems like the device tree
> approach is less intrusive.

Well, if this boards needs a factor 4 to be defined, it is IMHO
100 % correct to describe this in the DTS and nowhere else. Like
minimum and maximum voltage of a regulator which is also very board
specific.

Unless it can be figured out automatically. If it turns out later
that it can, I would assume the drivers can simply ignore the hint
in the DTS?

Just my 2cts without knowing details and having tested anything
on our DM37 boards.

BR,
Nikolaus
