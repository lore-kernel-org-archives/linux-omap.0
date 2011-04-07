From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for sharing with other platforms
Date: Fri, 8 Apr 2011 01:56:54 +0900
Message-ID: <20110407165654.GD8052@linux-sh.org>
References: <1302134569-22825-1-git-send-email-khilman@ti.com> <1302134569-22825-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302134569-22825-5-git-send-email-khilman@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@suse.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
> There is really nothing SH-mobile specific about this runtime PM
> implementation.  Any platform wanting to implement runtime PM based on
> simple clock gating can use this implementation.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

This observation is wholly architecture agnostic, so it's not clear that
keeping it in arch/arm/common is any better. It seems that this would be
better suited for drivers/base/power/ with a generic Kconfig symbol.
