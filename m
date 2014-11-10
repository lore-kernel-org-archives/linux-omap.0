From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: serial: remove last vestige of DTR_gpio
 support.
Date: Mon, 10 Nov 2014 09:07:18 -0800
Message-ID: <20141110170718.GM31454@atomide.com>
References: <20141108104246.1f2da822@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141108104246.1f2da822@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neilb@suse.de> [141107 15:44]:
> 
> These fields were added by:
> commit 9574f36fb801035f6ab0fbb1b53ce2c12c17d100
>     OMAP/serial: Add support for driving a GPIO as DTR.
> 
> but not removed by
> 
> commit 985bfd54c826c0ba873ca0adfd5589263e0c6ee2
>     tty: serial: omap: remove some dead code
> 
> which reverted most of that commit.
> Time to revert the rest.

Thanks applying into omap-for-v3.19/fixes-not-urgent.

Tony
