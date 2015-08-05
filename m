From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/7] phy: ti-pipe3: use ti_pipe3_power_off to power off
 the PHY during probe
Date: Wed, 5 Aug 2015 19:42:24 +0530
Message-ID: <55C219C8.8010304@ti.com>
References: <1438701646-7876-1-git-send-email-kishon@ti.com> <1438701646-7876-3-git-send-email-kishon@ti.com> <20150804160631.GH23659@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150804160631.GH23659-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 04 August 2015 09:36 PM, Felipe Balbi wrote:
> On Tue, Aug 04, 2015 at 08:50:41PM +0530, Kishon Vijay Abraham I wrote:
>> No functional change. Previously omap_control_phy_power() was used to power
> 
> there is a slight functional change. You moved PHY power off from before
> to after pm_runtime_enable(), clk_prepare_enable() and creation of the
> PHY device. That ought to have a slight impact on how the driver
> behaves.

okay. I'll modify the commit log. I think it won't impact the functionality as
such since the ->init and ->power_on callbacks won't be invoked at that point.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
