From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Fix NAND GPMC timings (for 3.17)
Date: Tue, 23 Sep 2014 09:03:00 -0700
Message-ID: <20140923160300.GC2451@atomide.com>
References: <1409918662-20547-1-git-send-email-rogerq@ti.com>
 <540D63E7.7000907@ti.com>
 <20140908224033.GO3238@atomide.com>
 <541FE4AF.4050701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541FE4AF.4050701@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140922 01:59]:
> Hi Tony,
> 
> On 09/09/2014 01:40 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [140908 01:08]:
> >> Hi Tony,
> >>
> >> This is needed for 3.17 otherwise NAND is broken on dra7-evm. Thanks.
> > 
> > Thanks applying into omap-for-v3.17/fixes-v2.
> > 
> 
> I don't see this branch. Did you put this patch somewhere else?

I had to redo the branch, it's in omap-for-v3.17/fixes-v3
that got merged into arm-soc fixes by Olof recently.

Regards,

Tony
