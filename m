From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Rename twl4030_ to twl_ in
 twl-regulator.c to make it generic reg
Date: Mon, 20 Jul 2009 21:54:22 +0300
Message-ID: <20090720185422.GD7984@gandalf>
References: <1248096765-14299-1-git-send-email-balajitk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753861AbZGTSyc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1248096765-14299-1-git-send-email-balajitk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balajitk@ti.com
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 20, 2009 at 07:02:45PM +0530, balajitk@ti.com wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
>  This patch renames all twl4030_ functions to twl so that regulator driver
>  can be reused by Triton - TWL4030 and Phoenix - TWL6030.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

and again.

-- 
balbi
