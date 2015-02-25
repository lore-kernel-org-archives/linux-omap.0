From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: build warning on v4.0-rc1
Date: Wed, 25 Feb 2015 21:45:00 +0000
Message-ID: <20150225214500.GM29656@ZenIV.linux.org.uk>
References: <20150225175143.GE11136@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225175143.GE11136@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 25, 2015 at 11:51:43AM -0600, Felipe Balbi wrote:
> Hi Al,
> 
> commit 3b994d98a815d934ab6a77a380882865982c14f9 (get rid of the second
> argument of acct_kill()) added a new build warning when building
> kernel/acct.c. Warning can be seen below. Revert of that commit is
> non-trivial, so I haven't tried to check if reverting it fixes the
> warning.

Warning is a false positive; we really do not care about the return
value here.
