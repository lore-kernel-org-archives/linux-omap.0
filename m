From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH V3 04/15] ARM: exynos: cleanup cppcheck shifting error
Date: Tue, 25 Jun 2019 20:49:51 +0200
Message-ID: <20190625184951.GA10025@kozik-lap>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
 <20190625040356.27473-5-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625040356.27473-5-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pierali
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 25, 2019 at 11:03:45AM +0700, Phong Tran wrote:
> There is error from cppcheck tool
> "Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
> change to use BIT() marco for improvement.
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 2 +-

Thanks, applied with slightly different commit message. As Peter
pointed, there is no error because of GCC.  Usually we expect a reply to
comments on LKML...  and also you could take his hints and use them to
improve the commit msg to properly describe what is the problem.

Best regards,
Krzysztof
