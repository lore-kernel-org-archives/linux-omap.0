From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] watchdog: sync linux-omap changes
Date: Fri, 19 Sep 2008 17:20:22 -0700
Message-ID: <200809191720.23375.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755985AbYITAUm@vger.kernel.org>
In-Reply-To: <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>
List-Id: linux-omap@vger.kernel.org

On Friday 19 September 2008, Felipe Balbi wrote:
> - * linux/drivers/char/watchdog/omap_wdt.c
> + * linux/drivers/watchdog/omap_wdt.c

current style omits the paths (just use "omap_wdt.c")
since they change periodically...
