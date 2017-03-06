From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/5] ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
Date: Mon, 6 Mar 2017 17:01:51 +0100
Message-ID: <20170306170151.0bb30576@jawa>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488813822-26042-3-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Mar 2017 09:23:39 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> Although all PG2.0 silicon may not support 1GHz OPP for the MPU, older
> Beaglebone Blacks may have PG2.0 silicon populated and these
> particular parts are guaranteed to support the OPP, so enable it for
> PG2.0 on am335x-boneblack only.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts
> b/arch/arm/boot/dts/am335x-boneblack.dts index
> 77273df1a028..935ed17d22e4 100644 ---
> a/arch/arm/boot/dts/am335x-boneblack.dts +++
> b/arch/arm/boot/dts/am335x-boneblack.dts @@ -15,3 +15,14 @@
>  	model = "TI AM335x BeagleBone Black";
>  	compatible = "ti,am335x-bone-black", "ti,am335x-bone",
> "ti,am33xx"; };
> +
> +&cpu0_opp_table {
> +	/*
> +	 * All PG 2.0 silicon may not support 1GHz but some of the
> early
> +	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
> +	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
> +	 */
> +	oppnitro@1000000000 {
> +		opp-supported-hw = <0x06 0x0100>;
> +	};
> +};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
