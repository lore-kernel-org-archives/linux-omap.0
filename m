From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap2+: GPMC NAND node fixes (part 2)
Date: Tue, 1 Mar 2016 10:01:15 -0800
Message-ID: <20160301180114.GZ13417@atomide.com>
References: <1456839888-6244-1-git-send-email-rogerq@ti.com>
 <56D59E13.4060502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D59E13.4060502@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, fcooper@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [160301 05:50]:
> On 01/03/16 15:44, Roger Quadros wrote:
> > Hi Tony,
> > 
> > These patches are a preparatory step towards the NAND DT cleanup
> > done in [1].
> > 
> > They mostly deal with adding the missing compatible property and
> > interrupt resources and fixing up register resources for the
> > NAND nodes for the boards that add NAND support in v4.6.
> > 
> > Patches based on tony/omap-for-v4.6/dt
> 
> [1] - http://article.gmane.org/gmane.linux.kernel/2156857

Thanks applying both into omap-for-v4.6/dt.

Regards,

Tony
