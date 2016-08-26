From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP1: use IS_ENABLED() instead of checking for
 built-in or module
Date: Fri, 26 Aug 2016 08:43:01 -0700
Message-ID: <20160826154301.p7lyj4qnkcl2kxdj@atomide.com>
References: <1470943785-21282-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470943785-21282-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160811 12:30]:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
> 
> Using the macro makes the code more readable by helping abstract away some
> of the Kconfig built-in and module enable details.

Applying both patches into omap-for-v4.9/soc thanks.

Tony
