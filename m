From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap device tree changes for v4.6 merge window, part 1
Date: Fri, 26 Feb 2016 13:58:21 -0800
Message-ID: <20160226215820.GK13417@atomide.com>
References: <20160222215612.GV13417@atomide.com> <6026634.ihuvqopRan@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <6026634.ihuvqopRan@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160226 13:35]:
> On Monday 22 February 2016 13:56:12 Tony Lindgren wrote:
> > Device tree changes for omaps for v4.6 merge window. Mostly just
> > adding board specific devices and few new boards:
> 
> Pulled into next/dt, with a trivial conflict resolution:
> 
> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> @@@ -110,6 -110,19 +110,11 @@@
>   
>   &i2c3 {
>   	clock-frequency = <400000>;
>  -};
>  -
>  -&i2c2 {
>  -	clock-frequency = <400000>;
>  -};
>  -
>  -&i2c3 {
>  -	clock-frequency = <400000>;
> + 	at24@50 {
> + 		compatible = "at24,24c02";
> + 		readonly;
> + 		reg = <0x50>;
> + 	};
>   };
>   
>   /*

OK looks god to me thanks.

Tony
