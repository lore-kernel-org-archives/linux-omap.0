From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: enable NEON based crypto
Date: Wed, 6 Sep 2017 13:12:10 -0700
Message-ID: <20170906201210.GO5024@atomide.com>
References: <20170906184729.7980-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170906184729.7980-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ard Biesheuvel <ard.biesheuvel@linaro.org> [170906 11:48]:
> Enable kernel mode NEON and the various NEON based crypto algorithms,
> which are between 1.4x (AES-XTS) and 2.4x (AES-GCM) faster than
> scalar code (measured on Cortex-A8).
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Note that this was tested using the updated GHASH code that is queued
> for v4.14

OK nice, will queue after the merge window. Some of these
also have hardware acceleration devices available.

Regards,

Tony

>  arch/arm/configs/omap2plus_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index a120ae816260..8e368c5514bf 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -512,3 +512,13 @@ CONFIG_LIBCRC32C=y
>  CONFIG_FONTS=y
>  CONFIG_FONT_8x8=y
>  CONFIG_FONT_8x16=y
> +CONFIG_KERNEL_MODE_NEON=y
> +CONFIG_ARM_CRYPTO=y
> +CONFIG_CRYPTO_SHA1_ARM=m
> +CONFIG_CRYPTO_SHA1_ARM_NEON=m
> +CONFIG_CRYPTO_SHA256_ARM=m
> +CONFIG_CRYPTO_SHA512_ARM=m
> +CONFIG_CRYPTO_AES_ARM=m
> +CONFIG_CRYPTO_AES_ARM_BS=m
> +CONFIG_CRYPTO_CHACHA20_NEON=m
> +CONFIG_CRYPTO_GHASH_ARM_CE=m
> -- 
> 2.11.0
> 
> 
> tcrypt.ko test on a Beaglebone White:
> 
> Baseline:
> 
> testing speed of async xts(aes) (xts(ecb(aes-arm))) encryption
> tcrypt: test 0 (256 bit key, 16 byte blocks): 339607 operations in 1 seconds (5433712 bytes)
> tcrypt: test 1 (256 bit key, 64 byte blocks): 209945 operations in 1 seconds (13436480 bytes)
> tcrypt: test 2 (256 bit key, 256 byte blocks): 79476 operations in 1 seconds (20345856 bytes)
> tcrypt: test 3 (256 bit key, 1024 byte blocks): 23687 operations in 1 seconds (24255488 bytes)
> tcrypt: test 4 (256 bit key, 8192 byte blocks): 2816 operations in 1 seconds (23068672 bytes)
> tcrypt: test 5 (384 bit key, 16 byte blocks): 322698 operations in 1 seconds (5163168 bytes)
> tcrypt: test 6 (384 bit key, 64 byte blocks): 191835 operations in 1 seconds (12277440 bytes)
> tcrypt: test 7 (384 bit key, 256 byte blocks): 70598 operations in 1 seconds (18073088 bytes)
> tcrypt: test 8 (384 bit key, 1024 byte blocks): 20766 operations in 1 seconds (21264384 bytes)
> tcrypt: test 9 (384 bit key, 8192 byte blocks): 2585 operations in 1 seconds (21176320 bytes)
> tcrypt: test 10 (512 bit key, 16 byte blocks): 303761 operations in 1 seconds (4860176 bytes)
> tcrypt: test 11 (512 bit key, 64 byte blocks): 176045 operations in 1 seconds (11266880 bytes)
> tcrypt: test 12 (512 bit key, 256 byte blocks): 63593 operations in 1 seconds (16279808 bytes)
> tcrypt: test 13 (512 bit key, 1024 byte blocks): 18447 operations in 1 seconds (18889728 bytes)
> tcrypt: test 14 (512 bit key, 8192 byte blocks): 2368 operations in 1 seconds (19398656 bytes)
> 
> testing speed of gcm(aes) (gcm_base(ctr(aes-generic),ghash-generic)) encryption
> test 0 (128 bit key, 16 byte blocks): 40657 operations in 1 seconds (650512 bytes)
> test 1 (128 bit key, 64 byte blocks): 26216 operations in 1 seconds (1677824 bytes)
> test 2 (128 bit key, 256 byte blocks): 10946 operations in 1 seconds (2802176 bytes)
> test 3 (128 bit key, 512 byte blocks): 6158 operations in 1 seconds (3152896 bytes)
> test 4 (128 bit key, 1024 byte blocks): 3291 operations in 1 seconds (3369984 bytes)
> test 5 (128 bit key, 2048 byte blocks): 1700 operations in 1 seconds (3481600 bytes)
> test 6 (128 bit key, 4096 byte blocks): 864 operations in 1 seconds (3538944 bytes)
> test 7 (128 bit key, 8192 byte blocks): 435 operations in 1 seconds (3563520 bytes)
> test 8 (192 bit key, 16 byte blocks): 39786 operations in 1 seconds (636576 bytes)
> test 9 (192 bit key, 64 byte blocks): 25096 operations in 1 seconds (1606144 bytes)
> test 10 (192 bit key, 256 byte blocks): 10336 operations in 1 seconds (2646016 bytes)
> test 11 (192 bit key, 512 byte blocks): 5804 operations in 1 seconds (2971648 bytes)
> test 12 (192 bit key, 1024 byte blocks): 3084 operations in 1 seconds (3158016 bytes)
> test 13 (192 bit key, 2048 byte blocks): 1537 operations in 1 seconds (3147776 bytes)
> test 14 (192 bit key, 4096 byte blocks): 810 operations in 1 seconds (3317760 bytes)
> test 15 (192 bit key, 8192 byte blocks): 407 operations in 1 seconds (3334144 bytes)
> test 16 (256 bit key, 16 byte blocks): 38714 operations in 1 seconds (619424 bytes)
> test 17 (256 bit key, 64 byte blocks): 24177 operations in 1 seconds (1547328 bytes)
> test 18 (256 bit key, 256 byte blocks): 9864 operations in 1 seconds (2525184 bytes)
> test 19 (256 bit key, 512 byte blocks): 5493 operations in 1 seconds (2812416 bytes)
> test 20 (256 bit key, 1024 byte blocks): 2915 operations in 1 seconds (2984960 bytes)
> test 21 (256 bit key, 2048 byte blocks): 1504 operations in 1 seconds (3080192 bytes)
> test 22 (256 bit key, 4096 byte blocks): 764 operations in 1 seconds (3129344 bytes)
> test 23 (256 bit key, 8192 byte blocks): 385 operations in 1 seconds (3153920 bytes)
> 
> NEON accelerated:
> 
> testing speed of async xts(aes) (xts-aes-neonbs) encryption
> tcrypt: test 0 (256 bit key, 16 byte blocks): 203520 operations in 1 seconds (3256320 bytes)
> tcrypt: test 1 (256 bit key, 64 byte blocks): 202474 operations in 1 seconds (12958336 bytes)
> tcrypt: test 2 (256 bit key, 256 byte blocks): 116650 operations in 1 seconds (29862400 bytes)
> tcrypt: test 3 (256 bit key, 1024 byte blocks): 33655 operations in 1 seconds (34462720 bytes)
> tcrypt: test 4 (256 bit key, 8192 byte blocks): 4330 operations in 1 seconds (35471360 bytes)
> tcrypt: test 5 (384 bit key, 16 byte blocks): 177757 operations in 1 seconds (2844112 bytes)
> tcrypt: test 6 (384 bit key, 64 byte blocks): 176166 operations in 1 seconds (11274624 bytes)
> tcrypt: test 7 (384 bit key, 256 byte blocks): 100618 operations in 1 seconds (25758208 bytes)
> tcrypt: test 8 (384 bit key, 1024 byte blocks): 28715 operations in 1 seconds (29404160 bytes)
> tcrypt: test 9 (384 bit key, 8192 byte blocks): 3690 operations in 1 seconds (30228480 bytes)
> tcrypt: test 10 (512 bit key, 16 byte blocks): 157310 operations in 1 seconds (2516960 bytes)
> tcrypt: test 11 (512 bit key, 64 byte blocks): 155785 operations in 1 seconds (9970240 bytes)
> tcrypt: test 12 (512 bit key, 256 byte blocks): 88755 operations in 1 seconds (22721280 bytes)
> tcrypt: test 13 (512 bit key, 1024 byte blocks): 25148 operations in 1 seconds (25751552 bytes)
> tcrypt: test 14 (512 bit key, 8192 byte blocks): 3230 operations in 1 seconds (26460160 bytes)
> 
> testing speed of gcm(aes) (gcm_base(ctr-aes-neonbs,ghash-ce)) encryption
> test 0 (128 bit key, 16 byte blocks): 29731 operations in 1 seconds (475696 bytes)
> test 1 (128 bit key, 64 byte blocks): 27946 operations in 1 seconds (1788544 bytes)
> test 2 (128 bit key, 256 byte blocks): 16242 operations in 1 seconds (4157952 bytes)
> test 3 (128 bit key, 512 byte blocks): 11364 operations in 1 seconds (5818368 bytes)
> test 4 (128 bit key, 1024 byte blocks): 7103 operations in 1 seconds (7273472 bytes)
> test 5 (128 bit key, 2048 byte blocks): 4057 operations in 1 seconds (8308736 bytes)
> test 6 (128 bit key, 4096 byte blocks): 2187 operations in 1 seconds (8957952 bytes)
> test 7 (128 bit key, 8192 byte blocks): 1127 operations in 1 seconds (9232384 bytes)
> test 8 (192 bit key, 16 byte blocks): 28346 operations in 1 seconds (453536 bytes)
> test 9 (192 bit key, 64 byte blocks): 26705 operations in 1 seconds (1709120 bytes)
> test 10 (192 bit key, 256 byte blocks): 15043 operations in 1 seconds (3851008 bytes)
> test 11 (192 bit key, 512 byte blocks): 10394 operations in 1 seconds (5321728 bytes)
> test 12 (192 bit key, 1024 byte blocks): 6426 operations in 1 seconds (6580224 bytes)
> test 13 (192 bit key, 2048 byte blocks): 3516 operations in 1 seconds (7200768 bytes)
> test 14 (192 bit key, 4096 byte blocks): 1955 operations in 1 seconds (8007680 bytes)
> test 15 (192 bit key, 8192 byte blocks): 1006 operations in 1 seconds (8241152 bytes)
> test 16 (256 bit key, 16 byte blocks): 27086 operations in 1 seconds (433376 bytes)
> test 17 (256 bit key, 64 byte blocks): 25591 operations in 1 seconds (1637824 bytes)
> test 18 (256 bit key, 256 byte blocks): 14002 operations in 1 seconds (3584512 bytes)
> test 19 (256 bit key, 512 byte blocks): 9575 operations in 1 seconds (4902400 bytes)
> test 20 (256 bit key, 1024 byte blocks): 5867 operations in 1 seconds (6007808 bytes)
> test 21 (256 bit key, 2048 byte blocks): 3307 operations in 1 seconds (6772736 bytes)
> test 22 (256 bit key, 4096 byte blocks): 1767 operations in 1 seconds (7237632 bytes)
> test 23 (256 bit key, 8192 byte blocks): 908 operations in 1 seconds (7438336 bytes)
> 
