From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: dts: dra7: Add vbb-supply to cpu and additional
 voltages
Date: Thu, 21 Dec 2017 07:15:36 -0800
Message-ID: <20171221151536.GR3875@atomide.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
 <1513697066-27732-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513697066-27732-2-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [171219 15:27]:
> Add a vbb-supply phandle to the cpus node and also add an additional
> triplet of voltages for each OPP in the operating-points-v2 table to
> make use of the multi regulator support in the OPP core and provide the
> vbb regulator for use by the ti-opp-supply driver.

Sounds like these depend on the ti-opp-supply being available first?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
