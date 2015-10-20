From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/1] ARM: DTS: dra72-evm: remove cpsw gpio hogging and
 add mode-gpios
Date: Tue, 20 Oct 2015 09:16:41 -0700
Message-ID: <20151020161640.GD3078@atomide.com>
References: <1442847231-23637-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442847231-23637-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> [150921 07:58]:
> With the current implementation of GPIO hogging and with
> gpio-pcf857x is built as module, ethernet doesn't work on boot
> and doesn't throw any error/warning to user. Ethernet becomes
> operational when inserting gpio-pcf857x module, even this time
> there is no error/warning logs to user that ethernet is
> operational.
> 
> When using with NFS rootfs and gpio-pcf857x as module, board
> doesn't boot as it doesn't get any ip address and doesn't throw
> any error/warning. To over come this, now cpsw driver tries to
> get mode-gpios. When gpio-pcf857x is built as module it will
> throw error, so that user can decide either to built in
> gpio-pcf857x to continue with nfs boot or choose alternate rootfs
> filesystem like sd/ramdisk.
> 
> When using mmc/ramdisk as root fs, cpsw will probe defer and
> re-probes again when gpio-pcf857x module is inserted and ethernet
> becomes operational.

Applying into omap-for-v4.4/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
