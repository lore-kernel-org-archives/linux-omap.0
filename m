From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2 v2] ARM: DRA7/335x/437x: hwmod: Remove gpmc address
 space from hwmod data
Date: Tue, 20 Oct 2015 07:36:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510200736480.28048@utopia.booyaka.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com> <1444926461-16092-2-git-send-email-fcooper@ti.com> <5620ACA4.907@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5620ACA4.907@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Oct 2015, Roger Quadros wrote:

> On 15/10/15 19:27, Franklin S Cooper Jr wrote:
> > GPMC address information is provided by device tree. No longer need
> > to include this information within hwmod.
> > 
> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Thanks, queued.


- Paul
