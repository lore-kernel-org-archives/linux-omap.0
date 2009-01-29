From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH D 11/11] Fix omap1 clock issues
Date: Thu, 29 Jan 2009 14:37:33 +0000
Message-ID: <20090129143733.GB18233@n2100.arm.linux.org.uk>
References: <20090128191638.16688.33452.stgit@localhost.localdomain> <20090128191844.16688.39372.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758771AbZA2OiA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090128191844.16688.39372.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 12:18:48PM -0700, Paul Walmsley wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> This fixes booting, and is a step toward fixing things properly:
> 
> - Make enable_reg u32 instead of u16

No, you're passing this to __raw_read/write, so it needs to be
void __iomem *, not u32.  If there's another patch doing that it
needs to be combined with this one.  The miniscule details of
fixes upon fixes aren't interesting for submission purposes, and
just adds extra unnecessary review load for upstream people.

Ditto for anything else which is passed to __raw_read/write*.
