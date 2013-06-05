From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: AM3XXX: Use preprocessor for device trees
Date: Wed, 5 Jun 2013 14:49:00 +0200
Message-ID: <51AF33BC.4020708@ti.com>
References: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, "Mohammed, Afzal" <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Joel A Fernandes <agnel.joel@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+ Afzal,

Hi Vaibhav and Afzal,

Can someone test this series before I pull it. I still don't have any AM
board to do it myself :-(

In theory, it should be fine since Florian already checked the diff, but
just in case.

Thanks,
Benoit


On 06/03/2013 04:12 PM, Florian Vaussard wrote:
> Hello,
> 
> Following my series for OMAP2+, this series makes use of the C preprocessor
> when compiling AM3xxx DT files, and accomplishes some improvements to improve
> overall readability.
> 
> The .dtb files were diff-tested before and after applying the series to
> guarantee identity for all targets.
> 
> To enable pullup/down on the pad, the bit should be cleared on AM33xx, where
> it should be set on OMAP3. This was wrong in my first version.
> 
> This series is based on Benoit's 'for_3.11/dts' branch.
> 
> Regards,
> 
> Florian
> 
> From v2:
> - Rebased on Benoit's 'for_3.11/dts'
> - Fixed inversed bit to enable pullups ('1' on OMAP, but '0' on AM33xx)
> 
> Florian Vaussard (4):
>   ARM: dts: AM3XXX: Use #include for all device trees
>   ARM: dts: AM33XX: Use existing constants for GPIOs
>   ARM: dts: AM33XX: Specific pinctrl header
>   ARM: dts: AM33XX: Use pinctrl constants
> 
>  arch/arm/boot/dts/am335x-bone.dts       |   28 ++++++------
>  arch/arm/boot/dts/am335x-evm.dts        |   76 +++++++++++++++---------------
>  arch/arm/boot/dts/am335x-evmsk.dts      |   46 +++++++++---------
>  arch/arm/boot/dts/am33xx.dtsi           |    5 ++-
>  arch/arm/boot/dts/am3517-evm.dts        |    2 +-
>  arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
>  include/dt-bindings/pinctrl/am33xx.h    |   37 +++++++++++++++
>  7 files changed, 118 insertions(+), 78 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/am33xx.h
> 
