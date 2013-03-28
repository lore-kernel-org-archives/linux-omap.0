From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH-V2 0/6] ARM: dts: AM33XX: Cleanup and pinctrl binding
 support
Date: Thu, 28 Mar 2013 13:26:39 +0100
Message-ID: <515436FF.9030703@ti.com>
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364452963-22083-1-git-send-email-hvaibhav-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: mporter-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Vaibhav,

The series looks good to me, but unfortunately does not apply cleanly on
top of the latest for_3.10/dts branch.

Could you rebase it?

Thanks,
Benoit

On 03/28/2013 07:42 AM, Vaibhav Hiremath wrote:
> This patch series fixes the numbering schema for I2C and GPIO
> module and adds the pin-control binding for I2C, UART, GPIO-LED across
> supported platforms (EVM, EVM-SK and Bone).
> 
> I have divided patches based on functionality and _not_
> into EVM/Board perspective.
> 
> Changes from V1: (no code change from last version, except uart)
> 	- Added Acked-by from Matt Porter and Peter Korsgaard
> 	  on couple of patches.
> 	- Added new patch (PATCH 5/6) in the series for UART
> 	  indexing fix
> 
> Vaibhav Hiremath (6):
>   ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
>   ARM: dts: AM33XX: Add default pinctrl binding for I2C device
>   ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM
>   ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
>   ARM: dts: AM33XX: Fix uart numbering to match hardware/TRM
>   ARM: dts: AM33XX: Add default pinctrl binding for UART0 device
> 
>  arch/arm/boot/dts/am335x-bone.dts  |   37 +++++++++++++++++++++-----
>  arch/arm/boot/dts/am335x-evm.dts   |   50 ++++++++++++++++++++++++++++-------
>  arch/arm/boot/dts/am335x-evmsk.dts |   45 ++++++++++++++++++++++++--------
>  arch/arm/boot/dts/am33xx.dtsi      |   38 +++++++++++++-------------
>  4 files changed, 123 insertions(+), 47 deletions(-)
> 
