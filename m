From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1/2: fix SoC name printing
Date: Thu, 29 Nov 2018 12:06:58 -0800
Message-ID: <20181129200657.GE53235@atomide.com>
References: <20181119194641.303-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119194641.303-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181119 11:46]:
> Currently we get extra newlines on OMAP1/2 when the SoC name is printed:
> 
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> 
> [    0.000000] OMAP2420
> [    0.000000]
> 
> Fix by using pr_cont.

Applying into omap-for-v4.21/omap1 thanks.

Tony
