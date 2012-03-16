From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4] misc: ddr: add LPDDR2 data from JESD209-2
Date: Fri, 16 Mar 2012 14:43:34 -0700
Message-ID: <20120316214334.GA24925@kroah.com>
References: <1331929177-11694-1-git-send-email-aneesh@ti.com>
 <1331931007-584-1-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331931007-584-1-git-send-email-aneesh@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 17, 2012 at 02:20:07AM +0530, Aneesh V wrote:
> add LPDDR2 data from the JEDEC spec JESD209-2. The data
> includes:
> 
> 1. Addressing information for LPDDR2 memories of different
>    densities and types(S2/S4)
> 2. AC timing data.
> 
> This data will useful for memory controller device drivers.
> Right now this is used by the TI EMIF SDRAM controller
> driver.
> 
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>

What happened to the other patches that depended on this one?

greg k-h
