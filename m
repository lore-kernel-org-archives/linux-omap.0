From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 4 Nov 2016 10:46:24 +0100
Message-ID: <20161104094624.GA19642@localhost.localdomain>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
 <20161101211358.GA2597@localhost.localdomain>
 <20161103205902.GB21430@atomide.com>
 <87r36rk5n9.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87r36rk5n9.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2016 at 10:31:38AM +0200, Felipe Balbi wrote:
[snip]
> Sounds like VBUS dropping to me. Remember, MUSB is really anal about
> VBUS levels. If it drops enough for the PHY to report one of those 4
> VBUS levels, then MUSB just gives up.
> 
> What we used to do back at Nokia was disable reporting of some of those
> VBUS levels at the PHY driver.

Well, I was getting these even without anything connected to musb:
[ 1526.594696] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_idle (90, <VBusValid), retry #0, port1 00000104
[  485.244781] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_idle (90, <VBusValid), retry #0, port1 00000104
...and with the hub connected:
[  562.803833] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_idle (90, <VBusValid), retry #0, port1 00000507
[   50.068664] musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_idle (90, <VBusValid), retry #0, port1 00000507
And indeed, after these errors musb gives up.

However these are gone with Tony's last patch. Bisecting now, approx 6 iterations left.

Best regards,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
