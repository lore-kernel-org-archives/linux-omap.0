From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: remove unused omap4-keypad file and code
Date: Mon, 19 May 2014 09:18:15 -0700
Message-ID: <20140519161814.GE4849@atomide.com>
References: <1400361851-32274-1-git-send-email-manabian@gmail.com>
 <1400361851-32274-2-git-send-email-manabian@gmail.com>
 <20140519053710.GD29386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140519053710.GD29386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joachim Eastwood <manabian@gmail.com>, illia.smyrnov@ti.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [140518 22:38]:
> On Sat, May 17, 2014 at 11:24:10PM +0200, Joachim Eastwood wrote:
> > This has been unused since omap4 board files went away.
> > 
> > Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> 
> Tony, can I merge both through my tree?

Yes I don't have anything touching the omap4_keyboard_init
areas that I can think of:

Acked-by: Tony Lindgren <tony@atomide.com>
 
