From: joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Fri, 10 Jun 2016 19:21:20 +0200
Message-ID: <4202511.EpuBn20QN5@saturn>
References: <201601091616.04193@pali> <2592499.y1ehgT9o2a@saturn> <575AF32B.2090705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575AF32B.2090705-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri 10 June 2016 12:04:43 Nishanth Menon wrote:
> I think there was some unfortunately choice of words used in the
> thread. It is TI intention to support community effort
[...]
> software, unfortunately these modes do not tend to be well tested and
> the typical "official disclaimer" is "Not for 'production device
> usage' and 'user might be on  his/her own' " 

Understood, agreed and appreciated, many thanks! :-)
I didn't mean to suggest this as the recommended way to implement hostmode on 
arbitrary devices, we just had to find a way to fix a hw-flaw in N900 platform. 
Odds are this N900 specific H-E-N botch won't work on any other platform ever.

Best Regards
jOERG
-- 
()  ascii ribbon campaign
/\  
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml          
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml    
http://www.gerstbach.at/2004/ascii/ (German)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
