From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Wed, 11 Apr 2012 20:44:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331934707-29487-1-git-send-email-aneesh@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mgreer@animalcreek.com, msalter@redhat.com
List-Id: linux-omap@vger.kernel.org

Cc Mark Greer, Mark Salter

Hi Greg, Aneesh,

On Sat, 17 Mar 2012, Aneesh V wrote:

> Add a driver for the EMIF SDRAM controller used in TI SoCs
> 
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.

Just checking to see what the current state of this series is.  Greg, are 
you considering this for merging, or are there remaining issues?  Aneesh, 
do you have any remaining issues to resolve with this set?

This is useful not only for OMAP4 and AM3517/3505, but also will probably 
be useful for the C6x chips that Mark Salter is working on.


- Paul
