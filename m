From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5 v3] usb: musb: Power management support
Date: Mon, 28 Feb 2011 10:56:11 +0200
Message-ID: <20110228085611.GL2459@legolas.emea.dhcp.ti.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298882976-4997-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Feb 28, 2011 at 02:19:31PM +0530, Hema HK wrote:
> This patch series supports the retention and offmode support in the 
> idle path for musb driver using runtime pm APIs.
> 
> This is restricted to support offmode and retention only when device not
> connected.When device/cable connected with gadget driver loaded, configured
> to no idle/standby which will not allow the core transition to retention
> or off.
> 
> There is no context save/restore done by hardware for musb in OMAP3
> and OMAP4,driver has to take care of saving and restoring the context
> during offmode.
> 
> Musb has a requirement of configuring sysconfig register to force
> idle/standby mode and set the ENABLE_FORCE bit in module STANDBY register
> for retention and offmode support.
> 
> Runtime pm and hwmod frameworks will take care of configuring to force
> idle/standby when pm_runtime_put_sync is called and back to no
> idle/standby when pm_runeime_get_sync is called.
> 
> Compile, boot tested and also tested the retention in the idle path on
> OMAP3630Zoom3. And tested the global suspend/resume with offmode enabled.
> Usb basic functionality tested on OMAP4430SDP.
> 
> There is some problem with idle path offmode in mainline, I could not test
> with offmode. But I have tested this patch with resetting the controller
> in the idle path when wakeup from retention just to make sure that the
> context is lost, and restore path is working fine.

Tony and Greg, how do we handle this one ? Who should take my pull request
for this series ? I hope we still have a little time to get this into
2.6.39, but if we don't I can hold on to them until 2.6.40.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
