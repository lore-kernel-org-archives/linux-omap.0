From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap1: fix incorrect placement of __initdata tag
Date: Thu, 3 Oct 2013 11:27:54 -0700
Message-ID: <20131003182754.GU8949@atomide.com>
References: <1861324.5ZgdrbcBQI@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1861324.5ZgdrbcBQI@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-omap@vger.kernel.org

* Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [130930 06:13]:
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.

Thanks applying into omap-for-v3.13/fixes-not-urgent.

Tony
