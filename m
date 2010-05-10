From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv4 3/4] mach-omap1: export omap1 info under /proc/socinfo
Date: Mon, 10 May 2010 11:52:00 +0100
Message-ID: <20100510105200.GA14337@n2100.arm.linux.org.uk>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com> <1273487857-32281-4-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1273487857-32281-4-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, Ambresh <a0393775@ti.com>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Mon, May 10, 2010 at 01:37:36PM +0300, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> Report OMAP name and rev under /proc/socinfo node.

I think this needs to be combined with the previous patch.  The previous
patch enables the socinfo file, which means with patch 2 applied but not
patch 3, OMAP1 breaks.
