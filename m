From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/3] ARM: omap1: avoid unused variable warning
Date: Wed, 24 Feb 2016 01:40:14 +0200
Message-ID: <20160223234013.GV1640@darkstar.musicnaut.iki.fi>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
 <1456235876-4088840-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456235876-4088840-3-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 23, 2016 at 02:57:52PM +0100, Arnd Bergmann wrote:
> The osk_mistral_init() contains code that is only compiled when
> CONFIG_PM is set, but it uses a variable that is declared outside
> of the #ifdef:
> 
> arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
> arch/arm/mach-omap1/board-osk.c:513:7: warning: unused variable 'ret' [-Wunused-variable]
> 
> This puts the variable in the same #ifdef to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
