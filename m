From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/8] Add TI EMIF SDRAM controller driver
Date: Thu, 8 Mar 2012 12:59:44 -0800
Message-ID: <20120308205944.GB16644@kroah.com>
References: <1331222065-3579-1-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331222065-3579-1-git-send-email-aneesh@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 08, 2012 at 09:24:17PM +0530, Aneesh V wrote:
> Add a driver for the EMIF SDRAM controller used in TI SoCs
> 
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.
> 
> The driver supports the following features:
> - Calculates the DDR AC timing parameters to be set in EMIF
>   registers using data from the device data-sheets and based
>   on the DDR frequency. If data from data-sheets is not available
>   default timing values from the JEDEC spec are used. These
>   will be safe, but not necessarily optimal
> - API for changing timings during DVFS or at boot-up
> - Temperature alert configuration and handling of temperature
>   alerts, if any for LPDDR2 devices
>   * temperature alert is based on periodic polling of MR4 mode
>     register in DDR devices automatically performed by hardware
>   * timings are de-rated and brought back to nominal when
>     temperature raises and falls respectively
> - Cache of calculated register values to avoid re-calculating
>   them
> 
> The driver will need some minor updates when it is eventually
> integrated with Dynamic Voltage and Frequency Scaling (DVFS).
> This can not be done now as DVFS support is not available in
> the mainline yet.

What will need to be updated in it?  The userspace interface or
something else?

Why not wait until that code is accepted, it should be going into 3.4,
right?

thanks,

greg k-h
