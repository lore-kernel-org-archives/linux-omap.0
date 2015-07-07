From: "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] extcon: fix hang and extcon_get/set_cable_state().
Date: Tue, 07 Jul 2015 15:40:45 +0300
Message-ID: <1436272845.2190.3.camel@linaro.org>
References: <1436194018-18696-1-git-send-email-rogerq@ti.com>
	 <1436194018-18696-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436194018-18696-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On Mon, 2015-07-06 at 17:46 +0300, Roger Quadros wrote:

> 
> -static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
> +static int find_cable_id_by_name(struct extcon_dev *edev, const char *name)
>  {
> -       unsigned int id = EXTCON_NONE;
> +       unsigned int id = -EINVAL;
>         int i = 0;
> 
> -       if (edev->max_supported == 0)
> -               return -EINVAL;
> -
> -       /* Find the the number of extcon cable */
> +       /* Find the id of extcon cable */
>         while (extcon_name[i]) {
>                 if (!strncmp(extcon_name[i], name, CABLE_NAME_MAX)) {
>                         id = i;
> @@ -140,6 +137,19 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
>                 }
>         }
> 

Thank you Roger, but this still hang. 'i' is not incremented.

Ivan

> +       return id;
> +};
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
