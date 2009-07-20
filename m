From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: Rename all twl4030_i2c*.
Date: Mon, 20 Jul 2009 21:53:28 +0300
Message-ID: <20090720185327.GB7984@gandalf>
References: <1248096736-14197-1-git-send-email-balajitk@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753824AbZGTSxh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1248096736-14197-1-git-send-email-balajitk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balajitk@ti.com
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, sameo@openedhand.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 20, 2009 at 07:02:16PM +0530, balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
>  This patch renames function names like twl4030_i2c_write_u8,
>  twl4030_i2c_read_u8 to twl_i2c_write_u8, twl_i2c_read_u8.
>  I2C address for modules(MADC, Battery Charger, Audio, RTC)
>  have changed between 4030 and 6030. Base address of these module register also
>  changed. Thus twl4030_map will be different for twl4030 and twl6030.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

same commet as previous patch

-- 
balbi
