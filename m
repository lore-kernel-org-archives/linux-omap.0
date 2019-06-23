From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 04/15] ARM: exynos: cleanup cppcheck shifting error
Date: Sun, 23 Jun 2019 21:12:37 +0200
Message-ID: <CAJKOXPfCrgS_iJAK0cxm0-XyGt6P2vq1FH4v2_8LSbfUp8gwUw@mail.gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com> <20190623151313.970-5-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-5-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, daniel@iogearbox.net, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sun, 23 Jun 2019 at 17:14, Phong Tran <tranmanphong@gmail.com> wrote:
>
> [arch/arm/mach-exynos/suspend.c:288]: (error) Shifting signed 32-bit
> value by 31 bits is undefined behaviour
>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Let's switch to BIT macro. It will solve the problem and is preferred
way of coding.

Best regards,
Krzysztof
