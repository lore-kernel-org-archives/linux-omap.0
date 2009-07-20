From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it
 generic rtc
Date: Mon, 20 Jul 2009 21:53:49 +0300
Message-ID: <20090720185349.GC7984@gandalf>
References: <1248096751-14256-1-git-send-email-balajitk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753855AbZGTSx5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1248096751-14256-1-git-send-email-balajitk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balajitk@ti.com
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Nayak Rajendra <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 20, 2009 at 07:02:31PM +0530, balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
>  This patch renames all twl4030_ functions to twl_ so that RTC driver can be
>  shared between Triton and Phoenix.  Register addresses which have changed will
>  be selected with COMPILATION FLAG
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Nayak Rajendra <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

same comment

-- 
balbi
