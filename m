From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource
 structure
Date: Fri, 10 Dec 2010 15:58:03 +0200
Message-ID: <20101210135803.GQ6027@legolas.emea.dhcp.ti.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
 <8762xo62b5.fsf@deeprootsystems.com>
 <4D012F2C.9060303@ru.mvista.com>
 <AANLkTimF3Eotqa+jZvzCJStguGrDEeS9V-XUGOTa9qBt@mail.gmail.com>
 <4D02237B.2070708@mvista.com>
 <20101210132053.GN6027@legolas.emea.dhcp.ti.com>
 <4D022C92.7090308@ru.mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D022C92.7090308-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 10, 2010 at 04:35:14PM +0300, Sergei Shtylyov wrote:
>>>>>>>Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>>>===================================================================
>>>>>>>--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>>>>>>>+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>>>@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
>>>>>>>{
>>>>>>>.start = IRQ_USBINT,
>>>>>>>.flags = IORESOURCE_IRQ,
>>>>>>>+ .name = "mc"
>>>>>>>},
>>>>>>>{
>>>>>>>/* placeholder for the dedicated CPPI IRQ */
>>>>>>>.flags = IORESOURCE_IRQ,
>>>>>>>+ .name = "dma"
>>>>>>>},
>>>>>>>};
>
>>>>>Argh! This failed to also modify da8xx_usb20_resources[]... :-(
>
>>>>I think when I posted these patch, da8xx support was not there in mainline.
>
>>>No, it was added long ago, before the glue layer itself.
>
>>>>I will send patch to add this.
>
>>>I will care about this myself now.
>
>>Thanks, send me the patch and I'll put to the same branch.
>
>   I was thinking about pushing this thru the DaVinci tree. Well, I'll 
>post to both lists and let you figure out who will apply it... :-)

If Kevin picks it up, fine by me :-)

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
