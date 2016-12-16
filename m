From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: debugfs: allow forcing host mode together
 with speed in testmode
Date: Thu, 15 Dec 2016 22:03:19 -0600
Message-ID: <20161216040319.GA18350@uda0271908>
References: <1481726877-18548-1-git-send-email-pali.rohar@gmail.com>
 <1481743425-25847-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481743425-25847-1-git-send-email-pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2016 at 08:23:45PM +0100, Pali Rohár wrote:
> Based on the musb ug, force_host bit is allowed to be set along with
> force_hs or force_fs bit.
> 
> It could help to implement forced host mode via testmode on Nokia N900.
> 
> Signed-off-by: Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_debugfs.c |   44 +++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
> index 9b22d94..62c13a2 100644
> --- a/drivers/usb/musb/musb_debugfs.c
> +++ b/drivers/usb/musb/musb_debugfs.c
> @@ -147,28 +147,34 @@ static int musb_test_mode_show(struct seq_file *s, void *unused)
>  
>  	test = musb_readb(musb->mregs, MUSB_TESTMODE);
>  
> -	if (test & MUSB_TEST_FORCE_HOST)
> +	if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS))

	if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS) ==
			MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS)

or even simpler:

	if (test == MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS)

since multiple tests at the same time are not allowed.

> +		seq_printf(s, "force host full-speed\n");
> +
> +	else if (test & (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS))

	else if (test == MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS)

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
