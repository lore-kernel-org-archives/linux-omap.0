From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 10/15] ARM: orion5x: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 17:23:19 +0200
Message-ID: <20190623152319.GD28942@lunn.ch>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190623151313.970-11-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190623151313.970-11-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.com, namhyung@kernel.org, tglx@linutronix.delinu
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 23, 2019 at 10:13:08PM +0700, Phong Tran wrote:
> [arch/arm/mach-orion5x/pci.c:281]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-orion5x/pci.c:305]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Maybe using the BIT() macro would be better, but this is O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
