From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: OMAP display kconfig options changing
Date: Tue, 29 Dec 2015 09:13:57 -0300
Message-ID: <CABxcv=n7kgHEq7yrAet2AZuQ15dzvcRMA3o-dE8r2ywdB_=+=w@mail.gmail.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
 <567430DB.4000507@ti.com>
 <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
 <56825F3E.5070602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56825F3E.5070602@ti.com>
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

On Tue, Dec 29, 2015 at 7:23 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Javier, Tony,
>
> On 22/12/15 23:18, Javier Martinez Canillas wrote:
>
>>> But if the userspace is using any omapfb specific apps, then yes, update
>>> is necessary.
>>>
>>
>> Yes but these people should have a migration plan anyways since omapfb
>> (and fbdev in general) is going away right?
>
> Well, I would guess most people don't know/care about that.
>

Fair enough.

>>> Ok. I think it's then best that I just update the defconfig to enable
>>> omapfb as modules, as it is currently.
>>>
>>
>> In that case I think you should squash the defconfig changes with
>> commit ("70ba4e05531f omapfb/displays: change CONFIG_DISPLAY_* to
>> CONFIG_FB_OMAP2_*") to maintain bisectability.
>
> Here's the diff to change the defconfig to enable the same items as before:
>
> diff --git a/arch/arm/configs/omap2plus_defconfig
> b/arch/arm/configs/omap2plus_defconfig
> index c5e1943e5427..b9581f1f0536 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -290,24 +290,23 @@ CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_FB_TILEBLITTING=y
> -CONFIG_OMAP2_DSS=m
> -CONFIG_OMAP5_DSS_HDMI=y
> -CONFIG_OMAP2_DSS_SDI=y
> -CONFIG_OMAP2_DSS_DSI=y
> +CONFIG_FB_OMAP5_DSS_HDMI=y
> +CONFIG_FB_OMAP2_DSS_SDI=y
> +CONFIG_FB_OMAP2_DSS_DSI=y
>  CONFIG_FB_OMAP2=m
> -CONFIG_DISPLAY_ENCODER_TFP410=m
> -CONFIG_DISPLAY_ENCODER_TPD12S015=m
> -CONFIG_DISPLAY_CONNECTOR_DVI=m
> -CONFIG_DISPLAY_CONNECTOR_HDMI=m
> -CONFIG_DISPLAY_CONNECTOR_ANALOG_TV=m
> -CONFIG_DISPLAY_PANEL_DPI=m
> -CONFIG_DISPLAY_PANEL_DSI_CM=m
> -CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=m
> -CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02=m
> -CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=m
> -CONFIG_DISPLAY_PANEL_TPO_TD028TTEC1=m
> -CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1=m
> -CONFIG_DISPLAY_PANEL_NEC_NL8048HL11=m
> +CONFIG_FB_OMAP2_ENCODER_TFP410=m
> +CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
> +CONFIG_FB_OMAP2_CONNECTOR_DVI=m
> +CONFIG_FB_OMAP2_CONNECTOR_HDMI=m
> +CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
> +CONFIG_FB_OMAP2_PANEL_DPI=m
> +CONFIG_FB_OMAP2_PANEL_DSI_CM=m
> +CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM=m
> +CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=m
> +CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=m
> +CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1=m
> +CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1=m
> +CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11=m
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_PLATFORM=y
>

Cool, that's what I changed to test omapfb as well. I can't test your
diff right now but looks correct to me.

Best regards,
Javier
