From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] bus: omap-ocp2scp: Fix error handling in
 omap_ocp2scp_probe
Date: Wed, 12 Jul 2017 02:26:16 -0700
Message-ID: <20170712092616.GC16509@atomide.com>
References: <20170711101638.2233-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170711101638.2233-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: nsekhar@ti.com, "arnd @ arndb . de" <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170711 03:17]:
> The error handling code in omap_ocp2scp_probe fails to invoke
> pm_runtime_disable and fails to initialize return value in
> certain cases. Fix it here.

Applying into omap-for-v4.13/fixes thanks.

Tony
