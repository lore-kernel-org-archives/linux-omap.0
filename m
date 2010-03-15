From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
Date: Mon, 15 Mar 2010 18:10:25 +0200
Message-ID: <20100315161024.GC3879@gandalf>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
 <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
 <4B9E187E.6090802@ru.mvista.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B9E187E.6090802-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Wang Hui <Hui.Wang-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 15, 2010 at 02:22:38PM +0300, Sergei Shtylyov wrote:
>    The whole musb_platform_set_mode() seems to be implemented 
> incorrectly on OMAPs -- it shouldn't touch the DevCtl.Session bit. This 

correct. It should be changing the id pin rules just like in tusb6010.c

> function should control the ID pin override instead -- if the controller 
> supports it. SRP must be initiated thru other means, i.e. 'srp' file in 
> sysfs.

via musb_gadget_wakeup()

-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
