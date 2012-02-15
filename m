From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Possible circular locking dependency (3.3-rc2)
Date: Wed, 15 Feb 2012 19:54:56 +0100
Message-ID: <CACRpkdZ7bs=i6Zg1ckXk-xBhY9z5VbvhVMk7p2_kP-=eB2bCKw@mail.gmail.com>
References: <20120208124147.GF16334@legolas.emea.dhcp.ti.com>
	<CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: balbi@ti.com, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 13, 2012 at 3:53 PM, Ming Lei <tom.leiming@gmail.com> wrote:

> Looks 'sysfs_lock' needn't to be held for unregister, so the patch below may
> fix the problem.

Looks correct to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
