From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Wed, 27 Jun 2012 07:58:45 -0700
Message-ID: <20120627145844.GL3483@atomide.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64137 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339Ab2F0O6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 10:58:48 -0400
Content-Disposition: inline
In-Reply-To: <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120626 23:53]:
> Reorganize gpmc-onenand initialization so that changes
> required for gpmc driver migration can be made smooth.
> 
> Ensuring sync read/write are disabled in onenand cannot
> be expected to work properly unless GPMC is setup, this
> has been removed.
> 
> Refactor set_async_mode & set_sync_mode functions to
> separate out timing calculation & actual configuration
> (GPMC & OneNAND side).

The last patch in this series causes onenand not to show
up on my n900. I believe the problem has been there earlier
too, but I just did not notice it.

Without the last patch in this series I get:

[    1.650207] OneNAND driver initializing
[    1.655487] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 83 MHz
[    1.666931] OneNAND Manufacturer: Numonyx (0x20)
[    1.671905] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    1.676971] OneNAND version = 0x0031
[    1.918762] Creating 6 MTD partitions on "omap2-onenand":

And with this patch applied I get:

[    1.634643] OneNAND driver initializing
[    1.640075] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0880000, freq 54 MHz
[    1.651519] OneNAND Manufacturer: Unknown (0xa0)

Any ideas?

Tony
