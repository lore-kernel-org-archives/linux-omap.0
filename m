From: Will Deacon <will.deacon@arm.com>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Tue, 24 Jan 2012 10:56:45 +0000
Message-ID: <20120124105645.GE19798@mudshark.cambridge.arm.com>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120124095009.GS16726@n2100.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Tue, Jan 24, 2012 at 09:50:09AM +0000, Russell King - ARM Linux wrote:
> Right, although it's out there - but I'd like to get the AMBA changes
> into it which are already conflicting the Samsung development.  So I'm
> going to hold off officially asking for people to include the baseline
> until this evening.  At that point, I will shut down my 'amba' branch
> and transfer that over; that means I won't be accepting any further
> acks etc for that work.
> 
> If you haven't acked changes in the amba branch (eg, to Versatile,
> Realview etc) then it'll soon be too late...

I took a look at your amba branch, but all I can see in there is:

6cfa627 ARM: 7079/1: spi: Fix builderror in spi-pl022.c
1c3be36 PM: add runtime PM support to MMCI
92b97f0 PM: add runtime PM support to core Primecell driver

which don't seem to touch Versatile or Realview. Am I looking in the wrong
place?

Cheers,

Will
