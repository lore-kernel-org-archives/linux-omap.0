From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/2] twl4030_codec cleanup
Date: Wed, 2 Mar 2011 15:34:34 +0100
Message-ID: <20110302143433.GM16181@sortiz-mobl>
References: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: peter.ujfalusi@nokia.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi Ilkka,

On Wed, Mar 02, 2011 at 03:24:04PM +0200, Ilkka Koskinen wrote:
> This series of patches removes duplicate audio_mclk fields from
> twl4030_codec driver.
> 
> The patches have been compiled on sound-2.6/for-2.6.39 branch.
> I haven't tested them on any target board though.
I'm fine with the twl.h changes, but I think it would make sense for Tony to
take this patchset. Tony, is that ok with you ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
