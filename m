From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] mfd: twl4030: clarify the return value for read and
 write
Date: Wed, 2 Dec 2009 15:41:44 +0200
Message-ID: <20091202134144.GL1361@nokia.com>
References: <1259760678-18707-1-git-send-email-amit.kucheria@verdurent.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35059 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZLBNmC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 08:42:02 -0500
Content-Disposition: inline
In-Reply-To: <1259760678-18707-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Amit Kucheria <amit.kucheria@verdurent.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, List Linux Omap <linux-omap@vger.kernel.org>

Hi,

On Wed, Dec 02, 2009 at 02:31:18PM +0100, ext Amit Kucheria wrote:
>@@ -298,10 +298,12 @@ int twl4030_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
> 	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
> 	mutex_unlock(&twl->xfer_lock);
>
>-	/* i2cTransfer returns num messages.translate it pls.. */
>-	if (ret >= 0)
>-		ret = 0;
>-	return ret;
>+	/* i2c_transfer returns number of messages transferred */
>+	if (ret != 1) {
>+		pr_err("%s: twl4030_i2c_write failed to transfer all messages\n", DRIVER_NAME);

this line is over 80-chars

>+		return ret;
>+	} else

you should have {} here as well.

>+		return 0;
> }
> EXPORT_SYMBOL(twl4030_i2c_write);
>
>@@ -350,10 +352,13 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
> 	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 2);
> 	mutex_unlock(&twl->xfer_lock);
>
>-	/* i2cTransfer returns num messages.translate it pls.. */
>-	if (ret >= 0)
>-		ret = 0;
>-	return ret;
>+	/* i2c_transfer returns number of messages transferred */
>+	if (ret != 2) {
>+		pr_err("%s: twl4030_i2c_read failed to transfer all messages\n", DRIVER_NAME);

over 80-chars

>+		return ret;
>+	}
>+	else

} else {

>+		return 0;

}

-- 
balbi
