From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 09:07:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
 <501AFA6B.4010005@gmail.com>
 <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com>
 <501B8997.2070307@gmail.com>
 <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com>
 <501B93AB.7050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501B93AB.7050501-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay Gupta <ajayg-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 14:32:35, Daniel Mack wrote:
> On 03.08.2012 10:43, Ajay Gupta wrote:
> >> On 03.08.2012 02:54, B, Ravi wrote:
> >>>> On 02.08.2012 14:12, Ravi Babu wrote:
> 
> >> However, I needed to add a phandle "usb0-phy = <&usb0_phy>" to the
> >> usb_otg_hs DTSI block, otherwise devm_usb_get_phy_by_phandle() in
> >> drivers/usb/musb/musb_dsps.c would fail. Is that correct? I can't seem to
> >> find that in your patches.
> > 
> > It's getting done in patch 11/11.
> 
> Ah, ok.
> 
> >> With this addition, I see the following:
> >>
> >> [    1.782180] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> >> [    1.809966] musb-hdrc musb-hdrc.0: MUSB HDRC host driver
> >> [    1.819068] musb-hdrc musb-hdrc.0: new USB bus registered, assigned
> >> bus number 1
> >> [    1.827970] usb usb1: New USB device found, idVendor=1d6b,
> >> idProduct=0002
> >> [    1.835184] usb usb1: New USB device strings: Mfr=3, Product=2,
> >> SerialNumber=1
> >> [    1.842818] usb usb1: Product: MUSB HDRC host driver
> >> [    1.848031] usb usb1: Manufacturer: Linux
> >> 3.6.0-rc1-00038-g8a1ec8f-dirty musb-hcd
> >> [    1.855933] usb usb1: SerialNumber: musb-hdrc.0
> >> [    1.866913] hub 1-0:1.0: USB hub found
> >> [    1.871192] hub 1-0:1.0: 1 port detected
> >> [    1.878106] musb-hdrc musb-hdrc.0: USB Host mode controller at
> >> d08c0000 using PIO, IRQ 18	
> >>
> >> ... but no USB functions. Also, every two seconds, the following message is
> >> printed:
> >>
> >> [   11.036608] musb_bus_suspend 2308: trying to suspend as a_wait_vrise
> >> while active
> >> [   13.044811] musb_bus_suspend 2308: trying to suspend as a_wait_vrise
> >> while active
> >> [   15.052196] musb_bus_suspend 2308: trying to suspend as a_wait_vrise
> >> while active
> > 
> > Do you see them even when you connect a device to port?
> 
> Yes. Will investigate more later today. Just wanted to know whether this
> is a typical config problem.
> 

Daniel

I have just pushed the code (V7 which Ravi submitted), so can you please try 
with below branch? 

https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
