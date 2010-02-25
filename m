From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] PCA953x : Fix compilation warning.
Date: Thu, 25 Feb 2010 15:27:08 +0100
Message-ID: <20100225152708.213775bd@hyperion.delvare>
References: <1267104758-32131-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267104758-32131-1-git-send-email-srk-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sriramakrishnan <srk-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 25 Feb 2010 19:02:38 +0530, Sriramakrishnan wrote:
> The platform data structure defined in pca953x header file
> includes references to i2c data structures. Unless the i2c.h
> file is included ahead of pca953x.h, compiler warning would
> be generated wherever pca953x header file is included. Added
> i2c.h to the pca953x.h itself to remove this dependency.
> 
> Also included conditional compile macros to guard against
> multiple inclusion.
> 
> Signed-off-by: Sriramakrishnan <srk-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/i2c/pca953x.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
> index 81736d6..1284a2d 100644
> --- a/include/linux/i2c/pca953x.h
> +++ b/include/linux/i2c/pca953x.h
> @@ -1,3 +1,8 @@
> +#ifndef __LINUX_PCA953X_H
> +#define __LINUX_PCA953X_H
> +
> +#include <linux/i2c.h>
> +
>  /* platform data for the PCA9539 16-bit I/O expander driver */
>  
>  struct pca953x_platform_data {
> @@ -17,3 +22,4 @@ struct pca953x_platform_data {
>  				void *context);
>  	char		**names;
>  };
> +#endif

Olof Johansson already sent a patch fixing this:
http://lkml.org/lkml/2010/1/5/327

Andrew Morton accepted this patch so it should go to Linus during the
next merge window (that is, within the next 2 weeks.)

-- 
Jean Delvare
