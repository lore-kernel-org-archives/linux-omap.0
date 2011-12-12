From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/4] fixes for twl4030-irq in mainline
Date: Mon, 12 Dec 2011 18:38:19 +0100
Message-ID: <20111212173819.GT13952@sortiz-mobl>
References: <20111126201334.16080.85045.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111126201334.16080.85045.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Neil,

On Sun, Nov 27, 2011 at 07:17:41AM +1100, NeilBrown wrote:
> Hi,
>   The recent tidying up of twl4030-irq seems to have left it broken.
> At least it doesn't work for me on my gta04 (www.gta04.org).  The
> first interrupt from the device freezes the whole system (by being
> constantly delivered)
> 
> The following 4 patches make it work for me and addresses some other
> less critical issues like a typo in a comment :-)

Thanks, I applied all 4 of them.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
