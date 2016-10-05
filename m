From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: PROBLEM: am3517 usb-ohci not working
Date: Wed, 5 Oct 2016 07:10:51 -0700
Message-ID: <20161005141051.ywtf6ebakhhvrmst@atomide.com>
References: <CALX2uoP-RN6SmEDOVcaBpJv+4kD2dY_iqxGjZu-5JFxdRAVfjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALX2uoP-RN6SmEDOVcaBpJv+4kD2dY_iqxGjZu-5JFxdRAVfjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?xYF1a2FzeiBQdcWCa2E=?= <lukasz-u2dlg1C4t1k@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Łukasz Pułka <lukasz-u2dlg1C4t1k@public.gmane.org> [161004 23:36]:
> 
> Can you point me what else should I check to make USB HS working in ohci mode?

Sounds like you're pretty close, in addition to the
pin muxing and PHY configuration, check also that you
have proper VBUS coming to the ports.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
