From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Tue, 28 May 2019 14:11:49 +0300
Message-ID: <af325707-3e42-493d-e858-77878ef06138@ti.com>
References: <20190510194229.20628-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510194229.20628-1-aford173@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/05/2019 22:42, Adam Ford wrote:
> Currently the source code is compiled using hard-coded values
> from CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK.  This patch allows this
> clock divider value to be moved to the device tree and be changed
> without having to recompile the kernel.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

I understand why you want to do this, but I'm not sure it's a good idea. 
It's really something the driver should figure out, and if we add it to 
the DT, it effectively becomes an ABI.

That said... I'm not sure how good of a job the driver could ever do, as 
it can't know the future scaling needs of the userspace at the time it 
is configuring the clock. And so, I'm not nacking this patch, but I 
don't feel very good about this patch...

The setting also affects all outputs (exluding venc), which may not be 
what the user wants. Then again, I think this setting is really only 
needed on OMAP2 & 3, which have only a single output. But that's the 
same with the current kconfig option, of course.

So, the current CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is an ugly hack, in my 
opinion, and moving it to DT makes it a worse hack =). But I don't have 
any good suggestions either.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
