From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm
 address space from hwmod data
Date: Fri, 23 Oct 2015 19:00:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510231858170.9575@utopia.booyaka.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 15 Oct 2015, Franklin S Cooper Jr wrote:

> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

The OMAP4 DTS files don't have the ELM address space declared.  I'm going 
to drop that portion of your patch.  Could you please send a two-patch 
series that first adds the ELM address space to the OMAP4 DTS file and 
then subsequently drops it from the OMAP4 hwmod data file?


- Paul
