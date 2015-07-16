From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/6] ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2
 and IRQSTATUS_MPU_2 register offsets
Date: Thu, 16 Jul 2015 02:40:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160239370.32764@utopia.booyaka.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com> <1436334148-9309-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com
List-Id: linux-omap@vger.kernel.org

On Wed, 8 Jul 2015, Keerthy wrote:

> The register offsets of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 are hardcoded.
> This makes it difficult to reuse the code for SoCs like AM437x that have
> a single instance of IRQENABLE_MPU and IRQSTATUS_MPU registers.
> Hence handling the case using offset of 4 to accommodate single set of IRQ*
> registers generically.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Thanks, queued for v4.3.


- Paul
