From: Paolo Pisati <paolo.pisati@canonical.com>
Subject: Re: [PATCH] regulator: core: if voltage scaling fails, restore
 original voltage values
Date: Fri, 14 Dec 2012 16:39:43 +0100
Message-ID: <20121214153943.GA3306@luxor.wired.org>
References: <1355389980-5532-1-git-send-email-paolo.pisati@canonical.com>
 <1355389980-5532-2-git-send-email-paolo.pisati@canonical.com>
 <20121213094715.GA1916@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121213094715.GA1916@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paolo Pisati <paolo.pisati@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2012 at 11:47:15AM +0200, Felipe Balbi wrote:
> On Thu, Dec 13, 2012 at 10:13:00AM +0100, Paolo Pisati wrote:
> > Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> 
> please read Documentation/stable_kernel_rules.txt, you'll see this is
> wrong.

you mean that i should have waited for the commit to hit Linus's tree before
cc-ing stable?

-- 
bye,
p.
