From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: sparse: add missing static
 declaration
Date: Thu, 16 Jul 2015 05:41:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160541090.32764@utopia.booyaka.com>
References: <cover.1436622578.git.nsekhar@ti.com>
 <21cca39eea23dfac76e6752fa2b2b62a4b1e15ad.1436622578.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <21cca39eea23dfac76e6752fa2b2b62a4b1e15ad.1436622578.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 11 Jul 2015, Sekhar Nori wrote:

> Add missing static declaration for file local variables.
> This fixes sparse warnings of type:
> 
> arch/arm/mach-omap2/omap_hwmod_81xx_data.c:491:26: warning: symbol 'dm81xx_alwon_l3_slow__gpmc' was not declared. Should it be static?
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks, queued for v4.3.


- Paul
