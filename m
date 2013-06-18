From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 2/2] musb: musb: dsps: determine the number of instances
 at runtime
Date: Tue, 18 Jun 2013 11:24:40 +0200
Message-ID: <51C02758.70501@linutronix.de>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de> <1371482014-5244-3-git-send-email-bigeasy@linutronix.de> <20130618083108.GH5461@arwen.pp.htv.fi> <51C01DCB.3030501@linutronix.de> <20130618085409.GO5461@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618085409.GO5461-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/18/2013 10:54 AM, Felipe Balbi wrote:
> Hi,

Hi Felipe,

>> This isn't exactly a child node, is it? There is
>> of_get_child_count() but this isn't a child, it is one property.
> 
> is it because we haven't added DTS support for musb core ?
> Eventually we can/should add and convert this to
> of_get_child_count() then. For now, we can go ahead with your
> approach.

 mother {
  	 child1 {
	 };
	 child1 {
	 };
 };

That would be a child imho.
For counting of phandles (for the number of assigned gpios for instance)
you would use
  of_count_phandle_with_args(node, "gpios", "#gpio-cell-size");

We don't have an equivalent for "#gpio-cell-size". In our case it would
be the sum of "#address-cells" and "#size-cells" minus 1 because we
don't have a phandle and abuse a function :)
Counting the number of "addresses" is special since bother its
members (address and size) can be either 32bit or 64bit in size.

> We have such a large amount of function pointers to sort out anyway
> :-(

If you want get the while() loop replaced by something else I have a
few suggestions:
- check for iomem(2). If it is there we have two instances. If not,
  just 1. This includes also the hope that we don't get a third port.

- loop over of_address_to_resource(). This is what of_device_alloc() is
  doing:
   if (of_can_translate_address(np))
         while (of_address_to_resource(np, num_reg, &temp_res) == 0)
                    num_reg++;
  So it is different.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
