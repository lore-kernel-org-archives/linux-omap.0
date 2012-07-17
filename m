From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC/PATCH 2/3] i2c: Fall back to emulated SMBus if the
 operation isn't supported natively
Date: Tue, 17 Jul 2012 17:02:43 +0200
Message-ID: <20120717170243.5def41a3@endymion.delvare>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1340720229-30356-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340720229-30356-3-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Tue, 26 Jun 2012 16:17:08 +0200, Laurent Pinchart wrote:
> Adapter drivers might support only a subset of the SMBus operations
> natively. Those drivers currently have to manually emulate unsupported
> operations using I2C.
> 
> Make the i2c_smbus_xfer() function fall back to
> i2c_smbus_xfer_emulated() when the adapter's .smbus_xfer() operation
> returns -EOPNOTSUPP, like it already does when the .smbus_xfer()
> operation isn't available at all.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 8cfa660..16e750e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2113,8 +2113,8 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>  		   union i2c_smbus_data *data)
>  {
>  	unsigned long orig_jiffies;
> +	s32 res = -EOPNOTSUPP;
>  	int try;
> -	s32 res;
>  
>  	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
>  
> @@ -2134,7 +2134,12 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
>  				break;
>  		}
>  		i2c_unlock_adapter(adapter);
> -	} else
> +	}
> +
> +	/* Fall back to i2c_smbus_xfer_emulated of the adapter doesn't implement
> +	 * native support for the SMBus operation.
> +	 */
> +	if (res == -EOPNOTSUPP && adapter->algo->master_xfer)
>  		res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
>  					      command, protocol, data);
>  

Looks good overall, but maybe the following variant would be preferable
from a performance perspective:

--- linux-3.5-rc7.orig/drivers/i2c/i2c-core.c	2012-07-17 16:35:42.566799611 +0200
+++ linux-3.5-rc7/drivers/i2c/i2c-core.c	2012-07-17 16:59:55.334530352 +0200
@@ -2140,11 +2140,17 @@ s32 i2c_smbus_xfer(struct i2c_adapter *a
 				break;
 		}
 		i2c_unlock_adapter(adapter);
-	} else
-		res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
-					      command, protocol, data);
 
-	return res;
+		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
+			return res;
+		/*
+		 * Fall back to i2c_smbus_xfer_emulated if the adapter doesn't implement
+		 * native support for the SMBus operation.
+		 */
+	}
+
+	return i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
+				       command, protocol, data);
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 

What do you think? The advantage is that we can skip the tests for
adapters which only implement adapter->algo->master_xfer().

-- 
Jean Delvare
