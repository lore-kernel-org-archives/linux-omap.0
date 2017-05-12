From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v5 3/3] phy: Group vendor specific phy drivers
Date: Fri, 12 May 2017 15:07:01 +0530
Message-ID: <8143c6b8-aaac-557b-98c1-00c957f3fcb6@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
 <5fe76bcc-5ff7-0bf1-7fdd-c141211d86dc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5fe76bcc-5ff7-0bf1-7fdd-c141211d86dc@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Stephen Boyd <stephen.boyd@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org



On 05/12/2017 02:15 PM, Kishon Vijay Abraham I wrote:
> Hi Vivek,
>
> On Thursday 11 May 2017 12:17 PM, Vivek Gautam wrote:
>> Adding vendor specific directories in phy to group
>> phy drivers under their respective vendor umbrella.
>>
>> Also updated the MAINTAINERS file to reflect the correct
>> directory structure for phy drivers.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Stephen Boyd <stephen.boyd@linaro.org>
>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-usb@vger.kernel.org
>> ---
>>
>> Changes since v4:
>>   - Reprepared the patch based on latest torvalds/master.
>>   - Added new directory for amlogic, since there's a new patch [1]
>>     coming in for amlogic platforms.
> I don't prefer placeholder directories but this is not a placeholder directory
> since phy-meson8b-usb2.c is already added in amlogic.

Right, since phy-meson8b-usb2.c was already there and phy-meson-gxl-usb2.c
is also coming, i decided to add this directory.
> Btw, thank you for sending this patch. Will queue this once -rc1 is tagged.

Cool. Thanks Kishon.

Regards
Vivek

>
> Cheers
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
