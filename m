From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix up interconnect barrier initialization
 for DRA7
Date: Wed, 30 Mar 2016 14:11:15 -0700
Message-ID: <20160330211114.GC9329@atomide.com>
References: <1457712748-1408-1-git-send-email-nm@ti.com>
 <4167118.MBvk7Vsb05@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4167118.MBvk7Vsb05@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [160311 08:46]:
> Hi Nishanth,
> 
> Thank you for the patch.
> 
> On Friday 11 March 2016 10:12:28 Nishanth Menon wrote:
> > The following commits:
> > commit 3fa609755c11 ("ARM: omap2: restore OMAP4 barrier behaviour")
> > commit f746929ffdc8 ("Revert "ARM: OMAP4: remove dead kconfig option
> > OMAP4_ERRATA_I688"") and
> > commit ea827ad5ffbb ("ARM: DRA7: Provide proper IO map table")
> > came in around the same time, unfortunately this seem to have missed
> > initializing the barrier for DRA7 platforms - omap5_map_io was reused
> > for dra7 till it was split out by the last patch. barrier_init
> > needs to be hence carried forward as it is valid for DRA7 family of
> > processors as they are for OMAP5.
> > 
> > Fixes: ea827ad5ffbb7 ("ARM: DRA7: Provide proper IO map table")
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applying into omap-for-v4.6/fixes with Cc stable thanks.

Tony
