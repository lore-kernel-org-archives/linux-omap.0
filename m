From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: OMAP display kconfig options changing
Date: Tue, 22 Dec 2015 18:18:30 -0300
Message-ID: <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
 <567430DB.4000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <567430DB.4000507@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Tomi,

On Fri, Dec 18, 2015 at 1:14 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 18/12/15 18:05, Tony Lindgren wrote:
>
>>> Are you referring to Kconfig options? Or userspace?
>>
>> Well sounds like both need updating :)
>
> Depends... For simple fb apps, omapdrm works fine, and X with the
> standard fbdev driver should work with omapdrm too.
>

It does, I just tested omapdrm + X with the fbdev DDX and I was able
to start X and the xfce4 wm.

I just needed to enable DRM_FBDEV_EMULATION in omap2plus_defconfig to
have fbdev emulation over DRM.

> But if the userspace is using any omapfb specific apps, then yes, update
> is necessary.
>

Yes but these people should have a migration plan anyways since omapfb
(and fbdev in general) is going away right?

>>> But no, I don't have links to either.
>>
>> So change the Kconfig options and then deal with the flood
>> of angry emails? :) I think we need instructions..
>
> Ok. I think it's then best that I just update the defconfig to enable
> omapfb as modules, as it is currently.
>

In that case I think you should squash the defconfig changes with
commit ("70ba4e05531f omapfb/displays: change CONFIG_DISPLAY_* to
CONFIG_FB_OMAP2_*") to maintain bisectability.

Alternatively, the current panel and encoders Kconfig symbols could
remain for omapfb since that's the current ones used in
omap2plus_defconfig where omapfb is the default and have new Kconfig
symbols for omapdrm (i.e: CONFIG_DRM_OMAP_ENCODER_TFP410).

> We can look again at changing the default to omapdrm after we've tested
> it on OMAP2 too, and we have a better idea what the user needs to take
> care of.
>
>  Tomi
>

Best regards,
Javier
