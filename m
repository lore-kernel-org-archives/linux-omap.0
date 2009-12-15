From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Tue, 15 Dec 2009 18:09:46 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAF46@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <20091214163324.GB31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAF0F@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD53A6@dbde02.ent.ti.com>
 <20091215121032.GH3689@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAF44@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAF44-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> It should be system's responsibility for not entering into suspend mode
> when
> there is an ongoing active transfer. If this is reliable then there is no
> need for any force disconnect.
> 
> On OMAP3EVM, I can see that system doesn't enter into suspend mode when
> cable is connected so should be fine for OMAP.
> 
> Felipe/Ajay,

oops! It's 'Felipe/Anand'.

-Ajay

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
