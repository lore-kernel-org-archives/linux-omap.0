From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: clock: DEFINE_STRUCT_CLK_FLAGS helper
Date: Thu, 31 Jan 2013 16:25:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311625120.32145@utopia.booyaka.com>
References: <cover.1358871018.git.afzal@ti.com> <abe7aceb564b97ab00b88b13a9aac487363e01c1.1358871018.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abe7aceb564b97ab00b88b13a9aac487363e01c1.1358871018.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 22 Jan 2013, Afzal Mohammed wrote:

> DEFINE_STRUCT_CLK does not have the capability to set flags, define
> DEFINE_STRUCT_CLK_FLAGS to handle flags. This is needed to add
> SET_RATE_PARENT flag in statically defined lcd clock in am335x.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Thanks, queued for 3.9.


- Paul
