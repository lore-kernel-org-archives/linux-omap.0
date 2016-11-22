From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2] mfd: twl-core: make driver DT only
Date: Tue, 22 Nov 2016 12:45:10 +0200
Message-ID: <20161122104510.iujd5revibqgbldl@tarshish>
References: <1479810090-12183-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479810090-12183-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Nicolae,

On Tue, Nov 22, 2016 at 12:21:30PM +0200, Nicolae Rosia wrote:
> All users are DT-only and it makes no sense to keep
> unused code which also prevents further cleanups.
> 
> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
> Changes in v2:
> Increased audience in CC list
> 
>  drivers/mfd/Kconfig    |   1 +
>  drivers/mfd/twl-core.c | 395 ++-----------------------------------------------
>  2 files changed, 10 insertions(+), 386 deletions(-)

[...]

> @@ -1080,7 +710,6 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
>  static int
>  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> -	struct twl4030_platform_data	*pdata = dev_get_platdata(&client->dev);

Can struct twl4030_platform_data declaration be removed now from 
include/linux/i2c/twl.h?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
