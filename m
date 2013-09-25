From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Wed, 25 Sep 2013 14:16:41 +0200
Message-ID: <2926093.ynDRy1bx5J@amdc1032>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <20130922215107.GD27616@mtj.dyndns.org> <524039E0.2060205@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <524039E0.2060205-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Monday, September 23, 2013 04:53:52 PM Sergei Shtylyov wrote:
> Hello.
> 
> On 23-09-2013 1:51, Tejun Heo wrote:
> 
> >>     Not sure why you asked -- I'm not using this driver, neither I'm
> 
> > Well, you have better grip of what's going on in the embedded world
> > than me.  I'm mostly curious whether adding dependency on PHY is okay.
> 
>     This driver already supports optional clock, the optional PHY support
> seems analogous.

Right, this reminds me that PHY support should probably also be added to
ahci_suspend() and ahci_resume().

Also please note the generic PHY framework is not yet merged in Linus'
tree so this patch should probably be merged only after the generic PHY
framework is in.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
