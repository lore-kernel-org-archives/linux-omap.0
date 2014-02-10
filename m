From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Select CONFIG_SOC_DRA7XX
Date: Mon, 10 Feb 2014 10:38:34 -0800
Message-ID: <7hlhxi95jp.fsf@paris.lan>
References: <1391700571-31784-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391700571-31784-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 6 Feb 2014 09:29:31 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> Select CONFIG_SOC_DRA7XX so that we can boot dra7-evm.
> DRA7 family are A15 based processors that supports LPAE and an
> evolutionary update to the OMAP5 generation of processors.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> based on v3.13-rc1 kernel tag - tested on v3.14-rc1 and next-20140206

Applied to arm-soc/fixes for v3.14-rc.

Kevin
