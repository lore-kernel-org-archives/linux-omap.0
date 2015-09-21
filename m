From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: DTS: dra72-evm: remove cpsw gpio hogging and add
 select-slave-gpio
Date: Mon, 21 Sep 2015 15:06:36 +0530
Message-ID: <55FFCFA4.5040503@ti.com>
References: <1442822686-28063-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442822686-28063-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 21 September 2015 01:34 PM, Mugunthan V N wrote:
> Since GPIO hogging fails to through error when booting with
> gpio-pcf857x as module and NFS root filesystem. So by having
> mode-gpio, it throw error to user so that the used can make
> gpio-pcf857x as inbuilt for NFS. When using mmc/ramdisk as root
> fs, cpsw will probe defer and re-probes again when gpio-pcf857x
> module is inserted and ethernet becomes operational.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

There is some typo error. Will submit a v2 ASAP

Regards
Mugunthan V N

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
