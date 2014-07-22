From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/misc/ti-st: Load firmware from ti-connectivity
 directory.
Date: Tue, 22 Jul 2014 16:24:18 -0700
Message-ID: <20140722232418.GA18997@kroah.com>
References: <1406027318-26186-1-git-send-email-eballetbo@iseebcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406027318-26186-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: pavan_savoy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 22, 2014 at 01:08:38PM +0200, Enric Balletbo i Serra wrote:
> Looks like the default location for TI firmware is inside the ti-connectivity
> directory, to be coherent with other firmware request used by TI drivers, load
> the TIInit firmware from this directory instead of /lib/firmware directly.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> ---
>  drivers/misc/ti-st/st_kim.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
> index 9d3dbb2..fa6a900 100644
> --- a/drivers/misc/ti-st/st_kim.c
> +++ b/drivers/misc/ti-st/st_kim.c
> @@ -244,7 +244,8 @@ static long read_local_version(struct kim_data_s *kim_gdata, char *bts_scr_name)
>  	if (version & 0x8000)
>  		maj_ver |= 0x0008;
>  
> -	sprintf(bts_scr_name, "TIInit_%d.%d.%d.bts", chip, maj_ver, min_ver);
> +	sprintf(bts_scr_name, "ti-connectivity/TIInit_%d.%d.%d.bts",
> +		chip, maj_ver, min_ver);

Can I get an ack from a ti.com address to verify that this is where the
driver really is?

thanks,

greg k-h
