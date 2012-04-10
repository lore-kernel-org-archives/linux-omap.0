From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/19] I2C updates
Date: Tue, 10 Apr 2012 20:26:51 +0530
Message-ID: <4F844A33.90609@ti.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com> <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com> <20120410114153.GR20616@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120410114153.GR20616-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "S, Venkatraman" <svenkatr-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 April 2012 05:11 PM, Felipe Balbi wrote:
> On Tue, Apr 10, 2012 at 05:01:37PM +0530, S, Venkatraman wrote:
>> On Tue, Apr 10, 2012 at 4:26 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
[...]
>>>  modpost: Fix modpost license checking of vmlinux.o (2012-04-09 20:52:56 -0700)
>>>
>>> are available in the git repository at:
>>>  git-OGgr7I4mDcYgsBAKwltoeQ@public.gmane.org:linus-tree/linus-tree.git i2c_omap-next
>> Minor nit:
>> You might want to indicate a git:// link instead of an ssh URL ?
> indeed, for those who haven't noticed git now has separate url and
> pushurl for every remote. Meaning you can pull and push with different
> urls. This solves this issue.
Thanks,
Venkat , Felipe

Here is the corrected pull request
The following changes since commit 258f742635360175564e9470eb060ff4d4b984e7:

  modpost: Fix modpost license checking of vmlinux.o (2012-04-09
20:52:56 -0700)

are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git i2c_omap-next

Jon Hunter (1):
      I2C: OMAP: Correct I2C revision for OMAP3

Shubhrajyoti D (16):
      I2C: OMAP: make omap_i2c_unidle/idle functions depend on
CONFIG_PM_RUNTIME
      I2C: OMAP: Remove reset at init
      I2C: OMAP: I2C register restore only if context is lost
      I2C: OMAP: Fix the interrupt clearing in OMAP4
      I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
      I2C: OMAP: Optimise the remove code
      I2C: OMAP: Fix the error handling
      I2C: OMAP: Don't check if wait_for_completion_timeout() returns
less than zero
      I2C: OMAP: use devm_* functions
      I2C: OMAP: Fix the crash in i2c remove
      I2C: OMAP: Handle error check for pm runtime
      I2C: OMAP: Use SET_RUNTIME_PM_OPS
      I2C: OMAP: make the read ready processing a separate function
      I2C: OMAP: Do not set the XUDF if the underflow is not reached
      I2C: OMAP: Rename the 1p153 to the erratum id i462
      ARM: OMAP4: hwmod data: I2C: add flag for context restore

Tasslehoff Kjappfot (1):
      I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153

Vikram Pandita (1):
      I2C: OMAP: Recover from Bus Busy condition

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +-
 arch/arm/plat-omap/i2c.c                   |    3 +
 drivers/i2c/busses/i2c-omap.c              |  342
+++++++++++++++-------------
 include/linux/i2c-omap.h                   |    1 +
 4 files changed, 194 insertions(+), 155 deletions(-)
