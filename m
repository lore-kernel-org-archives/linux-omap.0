From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] rtc: rename so the tps6586x-rtc module can be autoloaded
 at boot
Date: Tue, 10 May 2016 09:43:41 -0600
Message-ID: <573201AD.7080705@wwwdotorg.org>
References: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462876002-6462-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/10/2016 04:26 AM, Nicolas Chauvet wrote:
> This module is loaded by the related mfd driver which has
> the needed MODULE_DEVICE_TABLE(i2c,...).
>
> This patch fix the modalias when the rtc driver is built
> as a module, so the right name is used.
> Everything operates correctly when this module is builtin.

I'm sure this used to work. Do you know when/why it broke? Perhaps a 
Fixes: tag would be useful, and perhaps a Cc: stable?
