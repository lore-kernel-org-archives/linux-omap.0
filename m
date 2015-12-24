From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] OMAP: RX51: save atags data to be exported on /proc/atags
Date: Thu, 24 Dec 2015 16:50:33 +0100
Message-ID: <201512241650.33737.arnd@arndb.de>
References: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux@arm.linux.org.uk, tony@atomide.com, nicolas.pitre@linaro.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 24 December 2015, Ivaylo Dimitrov wrote:
> Nokia N900 legacy userspace needs ATAGS passed by the bootloder to be
> available in /proc/atags. With DT booted kernel this information is
> no longer availabe. Fix that by saving ATAGS data early in the boot 
> stage so it can be exported in /proc/atags later

Looks ok to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
