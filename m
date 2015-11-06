From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: Linus HEAD build break
Date: Fri, 6 Nov 2015 15:31:05 +0100
Message-ID: <CAAfyv35Dw_8jkoPOJek0Ta6Ve=fQ_xUiJcmxR5_NFfYOU+69Vg@mail.gmail.com>
References: <871tc31atk.fsf@saruman.tx.rr.com>
 <87y4ebyznc.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87y4ebyznc.fsf@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 6, 2015 at 3:24 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi again,
>
> Felipe Balbi <balbi@ti.com> writes:
>> Hi Marek,
>>
>> your commit af19161aaed7 ("ARM: dts: twl4030: Add iio properties for bci
>> subnode") breaks build on current linus/master (which current sits in
>
> this commit cannot be found in next. How come it's in linus/master ?
I did post fix but Tony seems doesn't merge it:
https://lkml.org/lkml/2015/10/13/816
>
> If it had been in next, we'd find out about it a lot sooner and avoid
> the build regression. It seems author didn't build his own patch,
> considering the error is clear. Here's a patch, please merge it or
> provide a better version. Below has been build tested
> (omap2plus_defconfig) and boot tested (am437x SK, am437x IDK, beaglebone
> black) (yeah, I don't have boards which sport MADC around).
>
> 8<---------------------------------------------------------------
>
> From 7af26f7123bad3e9c9dcfe9dfe9f4ad58e56f7cb Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <balbi@ti.com>
> Date: Fri, 6 Nov 2015 08:14:45 -0600
> Subject: [PATCH] ARM: dts: twl4030: fix Monitoring ADC label
>
> commit af19161aaed7 ("ARM: dts: twl4030: Add iio
> properties for bci subnode") breaks build of several
> DTS files by referring to a label that doesn't
> exist. Fix it.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 482b7aa37808..c8197f209efc 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,7 +22,7 @@
>         charger: bci {
>                 compatible = "ti,twl4030-bci";
>                 interrupts = <9>, <2>;
> -               io-channels = <&twl4030_madc 11>;
> +               io-channels = <&twl_madc 11>;
>                 io-channel-name = "vac";
>                 bci3v1-supply = <&vusb3v1>;
>         };
> --
> 2.6.2
>
>
>
> --
> balbi

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
