From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
Date: Mon, 18 Feb 2013 12:35:15 +0200
Message-ID: <20130218103515.GJ20771@intel.com>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@avionic-design.de>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Kevin Hilman <khilman@ti.com>, Sonic Zhang <sonic.zhang@analog.com>, linux-arm-kernel@lists.infradead.org, Deepak Sikri <deepak.sikri@st.com>, Havard Skinnemoen <hskinnemoen@gmail.com>, Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, uclinux-dist-devel@blackfin.uclinux.org, Jean Delvare <khali@linux-fr.org>, Lars-Peter Clausen <lars@metafoo.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Barry Song <baohua.son>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 15, 2013 at 03:18:35PM -0800, Doug Anderson wrote:
> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.
> * I verified that there were no cases where xxx_get_drvdata() was
>   being called in these drivers and checking for / relying on the NULL
>   return value.
> 
> This could be cleaned up kernel-wide but for now just take the baby
> step and remove from the i2c subsystem.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/i2c/busses/i2c-au1550.c             | 1 -
>  drivers/i2c/busses/i2c-bfin-twi.c           | 2 --
>  drivers/i2c/busses/i2c-cpm.c                | 2 --
>  drivers/i2c/busses/i2c-davinci.c            | 2 --
>  drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 --
>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 --

For i2c-designware-pcidrv.c and i2c-designware-platdrv.c:

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
