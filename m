From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
Date: Fri, 6 Nov 2015 21:21:30 +0100
Message-ID: <CAAfyv35kjW+x8+JmLFz0e0LBBpeHBqAU+qj++9aBT1PSiKRYyg@mail.gmail.com>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446826430-3705-1-git-send-email-sre@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 6, 2015 at 5:13 PM, Sebastian Reichel <sre@kernel.org> wrote:
> This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> which breaks the omap3 device tree build due to a wrong reference.
>
> I accidently queued this change via the power supply subsystem while
> telling Marek at the same time, that it should go through Tony's tree.
> Following that I did miss Stephen's messages about the build failure in
> linux-next and since he switched to merging an older snapshot nobody
> else noticed the problem in my tree. I didn't notice myself, since I
> did not build any device tree files assuming none have changed by me.
Sorry for the mess. But wouldn't be better to use correct fix instead of revert?
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  arch/arm/boot/dts/twl4030.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index 482b7aa37808..36ae9160b558 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -22,8 +22,6 @@
>         charger: bci {
>                 compatible = "ti,twl4030-bci";
>                 interrupts = <9>, <2>;
> -               io-channels = <&twl4030_madc 11>;
> -               io-channel-name = "vac";
>                 bci3v1-supply = <&vusb3v1>;
>         };
>
> --
> 2.6.2
>

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
