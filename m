From: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 13:28:12 +0100
Message-ID: <4E32A75C.5060400@warmcat.com>
References: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com> <20110729120711.GL31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110729120711.GL31013-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/29/2011 01:07 PM, Somebody in the thread at some point said:

Hi -

> -                       omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +                       if (dev->rev<  OMAP_I2C_REV_ON_3530_4430)
> +                               omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> +                                                               dev->westate);

> Andy, can you clarify why you added the revision check which didn't
> exist before ?
>
> [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commitdiff;h=a3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4
>

At the time I wrote the patches back in March, the code there was 
different: there was a pre-extant test avoiding that line on 4430, and 
the patch is simply converting it to the new scheme.  You can see it here:

http://permalink.gmane.org/gmane.linux.ports.arm.omap/54940

@@ -379,7 +379,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
  			 * REVISIT: Some wkup sources might not be needed.
  			 */
  			dev->westate = OMAP_I2C_WE_ALL;
-			if (dev->rev < OMAP_I2C_REV_ON_4430)
+			if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
  				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
  								dev->westate);
  		}

I guess since March and before this got committed for 3.1, someone got a 
patch in first removing the test, so when my patchset was uplevelled for 
commit against 3.1-rc this conflict was dealt with by re-introducing the 
test.

Long story short, it's there from me as a mechanical 1:1 renaming action 
as part of the fix that 3530 and 4430 (different) IPs return the same 
rev number.  Despite how it now looks I didn't add it, so if 
Shubhrajyoti has reasons to think it should be gone again I have nothing 
against that at all.

-Andy
