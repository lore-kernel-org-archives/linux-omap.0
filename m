From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 03 Aug 2012 13:41:38 +0200
Message-ID: <501BB8F2.8030909@gmail.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com> <501AFA6B.4010005@gmail.com> <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com> <501B8997.2070307@gmail.com> <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com> <501B93AB.7050501@gmail.com> <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7F4A3-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Cc: Ajay Gupta <ajayg-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
> I have just pushed the code (V7 which Ravi submitted), so can you please try 
> with below branch? 
> 
> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb

Thanks for doing this, but I'm unfortunately getting tons of merge
conflicts when I try to put this on top of 3.6-rc1. Still pondering
which way around is the easiest to get this solved.

OTOH, I wonder whether your staging branches would need to rebased
sooner or later anyway?


Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
