From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Fri, 6 Mar 2009 11:16:20 -0800
Message-ID: <200903061116.21544.david-b@pacbell.net>
References: <49B11EB0.30809@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756983AbZCFTQj@vger.kernel.org>
In-Reply-To: <49B11EB0.30809@nokia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: lrg@slimlogic.co.uk, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 06 March 2009, Adrian Hunter wrote:
> TWL4030 and TWL5030 support 3.0V on VAUX3.

I double checked several technical reference manuals, and they
say otherwise.   The 3.0V settings in VAUX3_DEDICATED are very
consistently labeled as "TI cannot support these values", for
all current versions of chips with a VAUX3 supply:

  TWL4030 ES3.1
  TWL5030 ES1.1
  TPS65930 ES1.0 (more or less a cost-reduced TWL5030)
  TPS65950 ES1.0 (more or less TWL5030)

So, NAK on this.

Do you really need 3.0V out of that regulator?  If so,
then I'd rather see a patch exposing that CONFIG_*
setting to enable all the unsupported/out-of-range
values, rather than just selectively hacking those
tables to permit some (but not all) of them to be used
out-of-range.


> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> 
> According to TI:
> http://community.ti.com/forums/t/3777.aspx

That looks to me like some random TI developer reading the
manual and ignoring the label on those settings:  Yes if you
set that value it'll probably work.  But no, if you rely on
that it's working out-of-spec, and is clearly marked as such.


 
> 
> 
>  drivers/regulator/twl4030-regulator.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/regulator/twl4030-regulator.c b/drivers/regulator/twl4030-regulator.c
> index 8655443..1755026 100644
> --- a/drivers/regulator/twl4030-regulator.c
> +++ b/drivers/regulator/twl4030-regulator.c
> @@ -224,7 +224,7 @@ static const u16 VAUX2_VSEL_table[] = {
>  };
>  static const u16 VAUX3_VSEL_table[] = {
>  	1500, 1800, 2500, 2800,
> -	UNSUP(3000), UNSUP(3000), UNSUP(3000), UNSUP(3000),
> +	3000, 3000, 3000, 3000,
>  };
>  static const u16 VAUX4_VSEL_table[] = {
>  	700, 1000, 1200, UNSUP(1300),
> -- 
> 1.5.6.3
> 
> 
