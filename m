From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Possible circular locking dependency (3.3-rc2)
Date: Wed, 15 Feb 2012 13:07:31 -0700
Message-ID: <20120215200731.GD25779@ponder.secretlab.ca>
References: <20120208124147.GF16334@legolas.emea.dhcp.ti.com>
 <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
 <CACRpkdZ7bs=i6Zg1ckXk-xBhY9z5VbvhVMk7p2_kP-=eB2bCKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ7bs=i6Zg1ckXk-xBhY9z5VbvhVMk7p2_kP-=eB2bCKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ming Lei <tom.leiming@gmail.com>, balbi@ti.com, Linus Walleij <linus.walleij@stericsson.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 15, 2012 at 07:54:56PM +0100, Linus Walleij wrote:
> On Mon, Feb 13, 2012 at 3:53 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> 
> > Looks 'sysfs_lock' needn't to be held for unregister, so the patch below may
> > fix the problem.
> 
> Looks correct to me!
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Ming, can I have a proper Signed-off-by: line from you so I can apply this
patch?

Thanks,
g.
