From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] ARM: OMAP2+: Add support for thumb mode on DT booted
 N900
Date: Fri, 21 Feb 2014 15:08:21 -0800
Message-ID: <20140221230821.GB5342@atomide.com>
References: <1391603582-11371-1-git-send-email-sre@debian.org>
 <1392672658-13866-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392672658-13866-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [140217 13:33]:
> Without enabling the workaround for ARM errata 430973 thumb
> compiled userland crashes randomly on the Nokia N900.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> ---
> Hi,
> 
> This is PATCHv2 for the thumb errata workaround for N900 DT
> boot, which should go into 3.14-rc.
> 
> Changes since PATCHv1:
>  * Add Reviewed-By: Pavel Machek
>  * Add more verbose warning about the errata as suggested by Pavel
> 
> I did not increase the verbose level, since the next higher verbose
> level is pr_err and the message is not an error.
> 
> I think it would make sense to update the Kconfig entry for the errata to
> enable the workaround by default for the Nokia N900. That should be done in
> its own patch, though.
> 
> Apart from that it would be nice if errata workaround could be enabled
> via DeviceTree instead of kernel configuration. This will require some
> discussion though, so I think we should start with this patch for now.

Thanks applying into omap-for-v3.14/fixes.

Tony
