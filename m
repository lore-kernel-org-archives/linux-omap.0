From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/8]usb: musb: HWMOD database structures fixes OMAP4
Date: Tue, 10 Aug 2010 10:42:01 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270944045@dbde02.ent.ti.com>
References: <1281110249-4098-1-git-send-email-hemahk@ti.com>
 <4C5FEBE4.1060707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C5FEBE4.1060707-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

>-----Original Message-----
>From: Cousson, Benoit 
>Sent: Monday, August 09, 2010 5:22 PM
>To: Kalliguddi, Hema
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH 4/8]usb: musb: HWMOD database structures 
>fixes OMAP4
>
>Hi Hema,
>
>On 8/6/2010 5:57 PM, Kalliguddi, Hema wrote:
>> From: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>>
>> Fixed the missing sysc settings for OMAP4 and enabled the OMAP4
>> hwmod data structure.
>>
>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi<felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
>It is a good practice, if not mandatory, to CC the authors of the file 
>you are modifying with your patch.
>Neither Paul, nor myself are in CC of this patch. Could you please add 
>us to this one and the other ones when applicable?

It is mistake of not CCing the owner. I will take care of it.
>
>> ---
>>
>> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> ===================================================================
>> --- 
>linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	
>2010-08-06 08:31:45.885868560 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	
>2010-08-06 08:35:41.250112281 -0400
>> @@ -4516,8 +4516,15 @@
>>    */
>>
>>   static struct omap_hwmod_class_sysconfig 
>omap44xx_usb_otg_hs_sysc = {
>> -	.sysc_flags	= SYSS_MISSING,
>> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>> +
>> +	.rev_offs	= 0x0400,
>> +	.sysc_offs	= 0x0404,
>> +	.syss_offs	= 0x0408,
>> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
>> +			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>> +			  SYSC_HAS_AUTOIDLE,
>> +	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
>> +	.sysc_fields	=&omap_hwmod_sysc_type1,
>>   };
>
>This part if fine except the missing MIDLE_XXX modes. Here is the 
>modified version using the same convention as other modules:

OK. I will add it.
>
> >  static struct omap_hwmod_class_sysconfig 
>omap44xx_usb_otg_hs_sysc = {
> > -       .sysc_flags     = SYSS_MISSING,
> > -       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> > +       .rev_offs       = 0x0400,
> > +       .sysc_offs      = 0x0404,
> > +       .syss_offs      = 0x0408,
> > +       .sysc_flags     = (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
> > +                          SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
> > +                          SYSC_HAS_SOFTRESET),
> > +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> > +                          MSTANDBY_FORCE | MSTANDBY_NO | 
>MSTANDBY_SMART),
> > +       .sysc_fields    = &omap_hwmod_sysc_type1,
> >  };
>
>I don't have any preference for the parens, but in order to be 
>consistent with the already existing hwmods, let's keep them.

There was comment from Sergie to remove the parens for omap3 database. So I have removed.
>
>Regards,
>Benoit
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
