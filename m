From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 4/6] twl4030_charger: Allow charger to control the
 regulator that feeds it.
Date: Wed, 9 May 2012 18:06:07 +0200
Message-ID: <20120509160607.GQ1794@sortiz-mobl>
References: <20120425072931.20124.56635.stgit@notabene.brown>
 <20120425073310.20124.68293.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120425073310.20124.68293.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Neil,

On Wed, Apr 25, 2012 at 05:33:11PM +1000, NeilBrown wrote:
> The charger needs usb3v1 to be running, so add a new consumer to
> keep it running.
> 
> This allows the charger to draw current even when the USB driver has
> powered down.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
>  drivers/mfd/twl-core.c          |    9 +++++----
>  drivers/power/twl4030_charger.c |   15 +++++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
In case Anton has not taken that patchset yet:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
