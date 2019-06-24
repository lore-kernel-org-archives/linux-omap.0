From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V2 10/15] ARM: orion5x: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 15:54:31 +0200
Message-ID: <20190624135431.GO31306@lunn.ch>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190624135105.15579-11-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-11-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieral
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:51:00PM +0700, Phong Tran wrote:
> [arch/arm/mach-orion5x/pci.c:281]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-orion5x/pci.c:305]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for swapping to the BIT macro.

       Andrew
