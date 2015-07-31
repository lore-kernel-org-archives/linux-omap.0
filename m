From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] extcon: fix hang and extcon_get/set_cable_state().
Date: Fri, 31 Jul 2015 12:43:35 +0900
Message-ID: <55BAEEE7.6000806@samsung.com>
References: <1436194018-18696-2-git-send-email-rogerq@ti.com>
 <1436274375-10308-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1436274375-10308-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

I add minor comment about code clean.
After I modified it by myself, I applied it on extcon-fixes.

Best Regards,
Chanwoo Choi

On 07/07/2015 10:06 PM, Roger Quadros wrote:
> Users of find_cable_index_by_name() will cause a kernel hang
> as the while loop counter is never incremented and end condition
> is never reached.
> 
> extcon_get_cable_state() and extcon_set_cable_state() are broken
> because they use cable index instead of cable id. This causes
> the first cable state (cable.0) to be always invalid in sysfs
> or extcon_get_cable_state() users.
> 
> Introduce a new function find_cable_id_by_name() that fixes
> both of the above issues.
> 
> Fixes: commit 73b6ecdb93e8 ("extcon: Redefine the unique id of supported external connectors without 'enum extcon' type")
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/extcon/extcon.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 76157ab..987dd3c 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -124,22 +124,34 @@ static int find_cable_index_by_id(struct extcon_dev *edev, const unsigned int id
>  	return -EINVAL;
>  }
>  
> -static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
> +static int find_cable_id_by_name(struct extcon_dev *edev, const char *name)
>  {
> -	unsigned int id = EXTCON_NONE;
> +	unsigned int id = -EINVAL;
>  	int i = 0;
>  
> -	if (edev->max_supported == 0)
> -		return -EINVAL;
> -
> -	/* Find the the number of extcon cable */
> +	/* Find the id of extcon cable */
>  	while (extcon_name[i]) {
>  		if (!strncmp(extcon_name[i], name, CABLE_NAME_MAX)) {
>  			id = i;
>  			break;
>  		}
> +

Remove blank line.

> +		i++;
>  	}
>  
> +	return id;
> +};
> +
> +static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
> +{
> +	unsigned int id = EXTCON_NONE;
> +
> +	if (edev->max_supported == 0)
> +		return -EINVAL;
> +
> +	/* Find the the number of extcon cable */
> +	id = find_cable_id_by_name(edev, name);
> +
>  	if (id == EXTCON_NONE)
>  		return -EINVAL;
>  
> @@ -228,9 +240,11 @@ static ssize_t cable_state_show(struct device *dev,
>  	struct extcon_cable *cable = container_of(attr, struct extcon_cable,
>  						  attr_state);
>  
> +	int i = cable->cable_index;
> +
>  	return sprintf(buf, "%d\n",
>  		       extcon_get_cable_state_(cable->edev,
> -					       cable->cable_index));
> +					       cable->edev->supported_cable[i]));
>  }
>  
>  /**
> @@ -341,6 +355,9 @@ int extcon_get_cable_state_(struct extcon_dev *edev, const unsigned int id)
>  {
>  	int index;
>  
> +	if (id == EXTCON_NONE)
> +		return -EINVAL;
> +

This if statement don't be necessary.
Instead, I check the error value on extcon_get_cable_state() by checking the
return value of find_cable_id_by_name().


>  	index = find_cable_index_by_id(edev, id);
>  	if (index < 0)
>  		return index;
> @@ -361,7 +378,7 @@ EXPORT_SYMBOL_GPL(extcon_get_cable_state_);
>   */
>  int extcon_get_cable_state(struct extcon_dev *edev, const char *cable_name)
>  {
> -	return extcon_get_cable_state_(edev, find_cable_index_by_name
> +	return extcon_get_cable_state_(edev, find_cable_id_by_name
>  						(edev, cable_name));

I modified it as following:
       unsigned int id;

       id = find_cable_id_by_name(edev, cable_name);
       if (id < 0)
               return id;

       return extcon_get_cable_state_(edev, id);

>  }
>  EXPORT_SYMBOL_GPL(extcon_get_cable_state);
> @@ -380,6 +397,9 @@ int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
>  	u32 state;
>  	int index;
>  
> +	if (id == EXTCON_NONE)
> +		return -EINVAL;
> +

ditto.

>  	index = find_cable_index_by_id(edev, id);
>  	if (index < 0)
>  		return index;
> @@ -404,7 +424,7 @@ EXPORT_SYMBOL_GPL(extcon_set_cable_state_);
>  int extcon_set_cable_state(struct extcon_dev *edev,
>  			const char *cable_name, bool cable_state)
>  {
> -	return extcon_set_cable_state_(edev, find_cable_index_by_name
> +	return extcon_set_cable_state_(edev, find_cable_id_by_name
>  					(edev, cable_name), cable_state);

ditto.

Thanks,
Chanwoo Choi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
