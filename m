From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap_hsmmc: consider MMC_PM_KEEP_POWER on
 suspend/resume
Date: Thu, 8 Dec 2011 16:28:37 -0800
Message-ID: <20111209002837.GF31337@atomide.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
 <87r50okviy.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r50okviy.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Eliad Peller <eliad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Chris Ball <cjb@laptop.org> [111201 09:40]:
> Hi,
> 
> On Tue, Nov 22 2011, Eliad Peller wrote:
> > When an mmc card has the MMC_PM_KEEP_POWER flag, it shouldn't
> > be powered off on suspend (and thus doesn't have to be powered-on
> > on resume)
> >
> > While on it, change the suspend flow a bit, to make it a bit
> > easier to follow.
> >
> > Signed-off-by: Eliad Peller <eliad@wizery.com>
> 
> Tony, feel free to merge this patchset (if you're happy with the rest of
> it) through your tree, with my:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
> for this patch.  Thanks,

Thanks applying these into omap driver branch.

Regards,

Tony
