From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
 handling
Date: Wed, 30 Dec 2009 15:46:43 +0200
Message-ID: <1262180803.17250.9.camel@gandalf>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	 <1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	 <4B3B3720.9070205@ru.mvista.com> <1262174012.28789.178.camel@gandalf>
	 <4B3B504B.4020602@ru.mvista.com> <1262178881.17250.1.camel@gandalf>
	 <4B3B54E1.9010600@ru.mvista.com> <1262179795.17250.7.camel@gandalf>
	 <4B3B58F0.2070903@ru.mvista.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B3B58F0.2070903-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 2009-12-30 at 16:43 +0300, Sergei Shtylyov wrote:
> > /*
> >  * Find the correct struct clk for the device and connection ID.
> >  * We do slightly fuzzy matching here:
> >  *  An entry with a NULL ID is assumed to be a wildcard.
> >  *  If an entry has a device ID, it must match
> >  *  If an entry has a connection ID, it must match
> >  * Then we take the most specific entry - with the following
> >  * order of precidence: dev+con > dev only > con only.
> >  */
> >
> > and then we have found our clock :-)
> 
>    Hm, you're right, I haven't completely followed the logic there... in 
> any case, specifying con_id wasn't really needed.

good we've sorted things out. Want me to send a patch for the device id
to davinci tree or can you take care of that ?

I have a for-kevin branch with a few patches I'll send to davinci tree
so I could add the device id patch there.

-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
