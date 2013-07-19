From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] dra7: I2C/MCSPI/UART pin control datas
Date: Fri, 19 Jul 2013 11:31:15 -0500
Message-ID: <51E969D3.2080804@ti.com>
References: <1374251050-10033-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374251050-10033-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
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
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/19/2013 11:24 AM, Sourav Poddar wrote:
> These series add support for I2C/MCSPI/UART pin control datas.
>
> The series is done on top of Rajendra Nayak series[1](posted to the list),
> which has basic dt boot enable for dra7.
> These patches has been tested, along with I2C and UART patches from
> wolfram sang patch series[2].
>
>
> [1]: http://www.spinics.net/lists/linux-omap/msg93535.html
> [2]: https://lkml.org/lkml/2013/7/10/335
>
> Sourav Poddar (4):
>    arm: dts: omap5-evm: Add I2c pinctrl data
>    arm: dts: omap5-evm: Add I2c pinctrl data
>    arm: dts: dra7-evm: Add SPI pinctrl data
>    arm: dts: dra7-evm: Add UART pinctrl data
>
>   arch/arm/boot/dts/dra7-evm.dts |  123 ++++++++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/dra7.dtsi    |   15 +++++
>   2 files changed, 138 insertions(+), 0 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
DRA7 DTS is not merged yet, If I am not mistaken.
Ref[1] [2]
So why not squash these to [2]?

[1] http://marc.info/?t=137335517900001&r=1&w=2
[2] http://marc.info/?l=linux-arm-kernel&m=137335590702349&w=2


-- 
Regards,
Nishanth Menon
