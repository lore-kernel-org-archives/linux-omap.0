From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 14/15] ARM: bpf: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 15:00:35 +0100
Message-ID: <20190624140035.36md6cp5ikniluwv@shell.armlinux.org.uk>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190624135105.15579-15-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-15-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieralisi@arm
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:51:04PM +0700, Phong Tran wrote:
> [arch/arm/net/bpf_jit_32.c:618]: (error) Shifting signed 32-bit value by
> 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/net/bpf_jit_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index adff54c312bf..4e8ad26305ca 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -612,7 +612,7 @@ static inline void emit_a32_mov_se_i64(const bool is64, const s8 dst[],
>  				       const u32 val, struct jit_ctx *ctx) {
>  	u64 val64 = val;
>  
> -	if (is64 && (val & (1<<31)))
> +	if (is64 && (val & (BIT(31))))

Extra parens are not necessary, please remove.

>  		val64 |= 0xffffffff00000000ULL;
>  	emit_a32_mov_i64(dst, val64, ctx);
>  }
> -- 
> 2.11.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
