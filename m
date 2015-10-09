From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Date: Sat, 10 Oct 2015 00:20:15 +0100
Message-ID: <20151009232015.GC32536@n2100.arm.linux.org.uk>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-cris-kernel@axis.com, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
> 
> In this patch, existing uses of this interface are simply updated
> with a null pointer.

This is a bad description.  It tells us what the patch is doing,
(which we can see by reading the patch) but not _why_.  Please include
information on why the change is necessary - describe what you are
trying to achieve.

I generally don't accept patches what add new stuff to the kernel with
no users of that new stuff - that's called experience, experience of
people who submit stuff like that, and then vanish leaving their junk
in the kernel without any users.  Please ensure that this gets a user
very quickly, or better still, submit this patch as part of a series
which makes use of it.

Also, copying soo many people is guaranteed to be silently dropped by
mailing lists.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
