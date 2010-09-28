From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/9 v3] usb: musb: Adding names for IRQs in resource
 structure
Date: Tue, 28 Sep 2010 15:18:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009281515590.5439@utopia.booyaka.com>
References: <1285201631-26266-1-git-send-email-hemahk@ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E94027863D959@dbde02.ent.ti.com> <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTim=ARtDA99XWP+RuB5nBh5FNAJHfSV34fiwtAk8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Mike,

On Tue, 28 Sep 2010, Mike Frysinger wrote:

> well, currently, your resource definition must always be in the order
> of dev int and then dma int.  if it isnt, then i dont think musb is
> going to work.
> 
> not sure why you wouldnt simply change your platform resources to
> match the what the driver expects ...

The resource data is getting automatically populated from a set of data 
generated from TI's hardware database for the OMAP platform, at least.  
While we could hack in some exceptions to that tool to generate resources 
in a specific order, it seems less fragile to use the resource name 
instead.  That way, no matter what order the resources are generated, the 
driver should still work.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
