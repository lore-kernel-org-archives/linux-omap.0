From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] ARM: omap1: add back missing includes
Date: Tue, 5 Mar 2013 22:27:33 +0000
Message-ID: <201303052227.33430.arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de> <1362521809-22989-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362521809-22989-6-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 March 2013, Arnd Bergmann wrote:
> The recent reorganization of OMAP header files caused a couple of
> files that used to be implicitly included now missing from OMAP1.
> This adds explicit inclusions of mach/irqs.h and mach/hardware.h
> in all files that need them for an OMAP1 allyesconfig build.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-omap1/board-fsample.c  | 1 +
>  arch/arm/mach-omap1/board-h2.c       | 1 +
>  arch/arm/mach-omap1/board-perseus2.c | 1 +
>  arch/arm/mach-omap1/board-sx1.c      | 1 +
>  drivers/video/omap/lcd_ams_delta.c   | 1 +
>  drivers/video/omap/lcd_osk.c         | 1 +
>  6 files changed, 6 insertions(+)

I saw that Tony has already addressed the latter two changes, but
did not see a fix for the four board files.

	Arnd
