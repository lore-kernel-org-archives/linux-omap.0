From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: sparse: add missing function declarations
Date: Thu, 16 Jul 2015 05:43:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160543100.32764@utopia.booyaka.com>
References: <cover.1436622578.git.nsekhar@ti.com>
 <3cb0fd46a493d80fad4d03316cdd6fb67a1938b7.1436622578.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3cb0fd46a493d80fad4d03316cdd6fb67a1938b7.1436622578.git.nsekhar@ti.com>
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

> omap3xxx_restart() and omap44xx_restart() are global
> functions declared in common.h. Include this file
> in omap3-restart.c and omap4-restart.c to prevent
> sparse warnings of type:
> 
> arch/arm/mach-omap2/omap4-restart.c:22:6: warning: symbol 'omap44xx_restart' was not declared. Should it be static?
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks, queued for v4.3.

- Paul
