From: "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Wed, 1 Aug 2012 11:08:17 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9DA02C@DBDE01.ent.ti.com>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
 <1343377927-7850-4-git-send-email-ravibabu@ti.com>
 <20120801102603.GF12869@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120801102603.GF12869-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 
Hi

> Subject: Re: [PATCH v6 04/11] usb: otg: nop: add support for 
> multiple tranceiver
> 
> On Fri, Jul 27, 2012 at 02:02:00PM +0530, Ravi B wrote:
> > +static void nop_put_id(int id)
> > +{
> > +
> > +	pr_info("removing id %d\n", id);
> 
> not pr_info. I guess pr_vdebug() is better. We don't want to 
> know about every new nop ID requested.

Ok. Agreed. 

Thanks
Ravibabu
> 
> --
> balbi
> --
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
