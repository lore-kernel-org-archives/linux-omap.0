From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Fri, 24 Sep 2010 13:56:46 +0300
Message-ID: <20100924105646.GT8365@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
 <87fwx02wl5.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E087@dbde02.ent.ti.com>
 <20100924084344.GJ8365@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E0DC@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863E128@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E128-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 24, 2010 at 04:28:35AM -0500, Kalliguddi, Hema wrote:
>I just noticed one more think in the code.  there are suspend/resume
>function pointers in platform_driver structure.  Why can't we use these
>for platform specific operations like enable/disable clocks, context
>save/restore?

For doing that properly, we first need to split the HW glue layer to
another parent platform_device/driver. Otherwise, we will have all sorts
of crazy stuff to change the function pointer depending on the ARCH.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
