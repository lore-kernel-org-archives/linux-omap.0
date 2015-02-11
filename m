From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: -n900 (not mainline): fix compilation with 3.20-rc0
Date: Thu, 12 Feb 2015 01:33:39 +0300
Message-ID: <54DBD8C3.4090904@cogentembedded.com>
References: <20150211222342.GE11313@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150211222342.GE11313@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 02/12/2015 01:23 AM, Pavel Machek wrote:

    This looked like a patch in its final form, so I decided to comment on it...

> commit 02aa41563bd0f14268d2142ab69694880d3425a1
> Author: Pavel <pavel@ucw.cz>
> Date:   Wed Feb 11 23:22:51 2015 +0100

    No need for this header.

>      Fix compilation of wl1251 specific parts with 3.20-rc0.

>      Signed-off-by: Pavel Machek <pavel@ucw.cz>

    Please don't indent the change log.

> diff --git a/drivers/net/wireless/ti/wl1251/netlink.c b/drivers/net/wireless/ti/wl1251/netlink.c
> index e5f5a45..90a5486 100644
> --- a/drivers/net/wireless/ti/wl1251/netlink.c
> +++ b/drivers/net/wireless/ti/wl1251/netlink.c
[...]
> @@ -406,14 +398,10 @@ static int wl1251_nl_phy_reg_read(struct sk_buff *skb, struct genl_info *info)
>   	if (nla_put_u32(msg, WL1251_NL_ATTR_REG_VAL, *reg_value))
>   		goto nla_put_failure;
>
> -	ret = genlmsg_end(msg, hdr);
> -	if (ret < 0) {
> -		wl1251_error("%s() failed", __func__);
> -		goto nla_put_failure;
> -	}
> +	genlmsg_end(msg, hdr);
>
>   	kfree(reg_value);
> -
> +	

    Remove this stray tab please.

>   	return genlmsg_reply(msg, info);
>
>   nla_put_failure:

WBR, Sergei
