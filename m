From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am3874-iceboard: Fix 'i2c-mux-idle-disconnect'
 usage
Date: Tue, 8 Oct 2019 07:16:59 -0700
Message-ID: <20191008141659.GC5610@atomide.com>
References: <20191004014548.29583-1-andrew.smirnov@gmail.com>
 <c40b8414-45a8-575a-c3c8-902ed35e5764@threespeedlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c40b8414-45a8-575a-c3c8-902ed35e5764@threespeedlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Graeme Smecher <gsmecher@threespeedlogic.com> [191004 23:53]:
> Hi Andrey,
> 
> On 2019-10-03 6:45 p.m., Andrey Smirnov wrote:
> > According to
> > Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt,
> > i2c-mux-idle-disconnect is a property of a parent node since it
> > pertains to the mux/switch as a whole, so move it there and drop all
> > of the concurrences in child nodes.
> > 
> > Fixes: d031773169df ("ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874")
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Benoît Cousson <bcousson@baylibre.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Graeme Smecher <gsmecher@threespeedlogic.com>
> > Cc: linux-omap@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > 
> > This is purely a drive-by fix, since it concerns the HW I've never
> > heard of before. However I was working with PCA9548
> > (vf610-zii-scu4-aib is my HW) and looking at various users in the
> > kernel, when this code caught my eye. Apologies for the noise if this
> > fix is somehow bogus.
> > 
> > In case that it matters this patch is based on top of 5.4-rc1.
> 
> Thanks! We do have I2C address collisions on downstream bus segments, so
> keeping these segments isolated is important. I'm surprised this patch
> was necessary and happy to see it.
> 
> Lightly tested on 5.3.
> 
> Tested-by: Graeme Smecher <gsmecher@threespeedlogic.com>

Applying into fixes thanks.

Tony
