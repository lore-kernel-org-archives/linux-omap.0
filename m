From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove legacy macros for zoom platforms
Date: Thu, 13 Feb 2014 15:30:00 -0800
Message-ID: <20140213233000.GT28216@atomide.com>
References: <1392198352.23759.10.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392198352.23759.10.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [140212 01:48]:
> Commit 97411608fd5f ("ARM: OMAP2+: Remove legacy support for zoom
> platforms") removed the Kconfig symbols MACH_OMAP_ZOOM2 and
> MACH_OMAP_ZOOM3. Remove the last usage of the related macros too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested, but should have zero impact.

Thanks applying into omap-for-v3.14/fixes.

Tony
