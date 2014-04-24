From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH V2 00/19] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
Date: Thu, 24 Apr 2014 10:54:04 -0500
Message-ID: <20140424155403.GA29229@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Nishanth,

Nishanth Menon <nm@ti.com> wrote on Thu [2014-Apr-17 15:49:16 -0500]:
> 
> V2 introduces the following changes:
> 	- Additional bug fix detected during additional testing (all tests complete now). patch #12
> 	- reordering of patches to order logical changes and reduce code churn.
> 	- interrupt handler split up and additional information now provided in log to aid debug when error occur
> 	- patches are marked where new (12,14,15,16).
> 	- DRA7 updated from master document for all DRA7 variants.
> 
> This series cleansup omap_l3_noc driver and adds data to support DRA7
> and AM437x SoCs.
> 
This L3 noc driver patch series is working great for me and has already
flagged a very difficult to detect problem in a driver I am working on
with a DMA access to an invalid memory address on DRA7.

Tested-by: Darren Etheridge <detheridge@ti.com>


Darren
