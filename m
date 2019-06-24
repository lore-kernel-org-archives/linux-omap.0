From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 01/15] arm: perf: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 09:11:21 +0200
Message-ID: <20190624071121.GN3436@hirez.programming.kicks-ass.net>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190623151313.970-2-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190623151313.970-2-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.com, namhyung@kernel.org, tglx@linutronix.de, linux-omap
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 23, 2019 at 10:12:59PM +0700, Phong Tran wrote:
> fix "Shifting signed 32-bit value by 31 bits is undefined behaviour
> errors"
> 
> [arch/arm/kernel/perf_event_v7.c:1080]: (error) Shifting signed 32-bit
> value by 31 bits is undefined behaviour
> [arch/arm/kernel/perf_event_v7.c:1436]: (error) Shifting signed 32-bit
> value by 31 bits is undefined behaviour
> [arch/arm/kernel/perf_event_v7.c:1783]: (error) Shifting signed 32-bit
> value by 31 bits is undefined behaviour

I don't think that is true; the kernel uses -fno-strict-overflow (which
implies -fwrapv) and that takes away all the signed UB.
