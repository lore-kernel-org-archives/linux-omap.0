From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] net: ethernet: ti: ale: ensure vlan/mdb deleted when no
 members
Date: Thu, 28 Nov 2019 10:21:27 +0200
Message-ID: <20191128082127.GA16359@apalos.home>
References: <20191127155905.22921-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127155905.22921-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 27, 2019 at 05:59:05PM +0200, Grygorii Strashko wrote:
> The recently updated ALE APIs cpsw_ale_del_mcast() and
> cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
> if VLAN/mcast group has no more members. Hence fix it here and delete ALE
> entry if !port_mask.
> 
> The issue affected only new cpsw switchdev driver.
> 
> Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw_ale.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 929f3d3354e3..a5179ecfea05 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -396,12 +396,14 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
>  	if (port_mask) {
>  		mcast_members = cpsw_ale_get_port_mask(ale_entry,
>  						       ale->port_mask_bits);
> -		mcast_members &= ~port_mask;
> -		cpsw_ale_set_port_mask(ale_entry, mcast_members,
> +		port_mask = mcast_members & ~port_mask;
> +	}
> +
> +	if (port_mask)
> +		cpsw_ale_set_port_mask(ale_entry, port_mask,
>  				       ale->port_mask_bits);
> -	} else {
> +	else
>  		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> -	}

The code assumed calls cpsw_ale_del_mcast() should have a port mask '0' when
deleting an entry. Do we want to have 'dual' functionality on it? 
This will delete mcast entries if port mask is 0 or port mask matches exactly
what's configured right?

>  	cpsw_ale_write(ale, idx, ale_entry);
>  	return 0;
> @@ -478,6 +480,10 @@ static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
>  	members = cpsw_ale_get_vlan_member_list(ale_entry,
>  						ale->vlan_field_bits);
>  	members &= ~port_mask;
> +	if (!members) {
> +		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> +		return;
> +	}

This makes sense the call was missing 

>  
>  	untag = cpsw_ale_get_vlan_untag_force(ale_entry,
>  					      ale->vlan_field_bits);
> -- 
> 2.17.1
> 


Thanks
/Ilias
