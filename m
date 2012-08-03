From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Fri, 03 Aug 2012 10:54:27 -0700
Message-ID: <m2628z6euk.fsf@firstfloor.org>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com> (Vikram
	Pandita's message of "Fri, 3 Aug 2012 09:56:44 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: gregkh@linuxfoundation.org, kay@vrfy.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>
List-Id: linux-omap@vger.kernel.org

Vikram Pandita <vikram.pandita@ti.com> writes:

> From: Vikram Pandita <vikram.pandita@ti.com>
>
> Introduce config option to enable CPU id reporting for printk() calls.

What's wrong with using trace_printk for this? That's much faster
anyways. Generally printk is so slow that it's typically useless for
instrumenting races.

And really: Wasting 1/3 of the 80 character line is too much.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
