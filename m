From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 11/14] OMAP clock: track child clocks
Date: Tue, 3 Mar 2009 16:45:49 +0000
Message-ID: <20090303164548.GD11096@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192756.29333.41541.stgit@localhost.localdomain> <20090129151401.GC18233@n2100.arm.linux.org.uk> <20090129220608.GJ18233@n2100.arm.linux.org.uk> <20090219121932.GL6407@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE896716203772C3680@dlee02.ent.ti.com> <20090223160349.GB27688@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0903021558360.30037@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759094AbZCCQq3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903021558360.30037@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 02, 2009 at 04:02:14PM -0700, Paul Walmsley wrote:
> Suggest returning a more specific error than -EINVAL:
> 
> if (clk->usecount > 0)
>         return -EBUSY;

Done.
