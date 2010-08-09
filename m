From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Mon, 09 Aug 2010 14:01:26 -0700
Message-ID: <87k4nzijq1.fsf@deeprootsystems.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com>
	<4C5FFC25.4060707@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270943E2D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270943E2D-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
	(Hema Kalliguddi's message of "Mon, 9 Aug 2010 18:42:34 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org> writes:

[...]

>>>
>>> Changed the usb sysconfig settings as per the usbotg functional spec.
>>> When the device is not active, configure to force idle and 
>>force standby mode.
>>> When it is being used, configure in smart standby and smart 
>>idle mode.
>>> So while attempting to coreoff the usb is configured to 
>>force standby and
>>> force idle mode, after wakeup configured in smart idle and 
>>smart standby.
>>
>>Is this valid for OMAP3 and OMAP4? I checked quickly the OMAP4 
>>TRM vB in 
>>the USB_OTG chapter related to PM (23.13.4.2 Power-Management), and I 
>>cannot find any note regarding that specific programming model.
>>Could give us reference to the documentation that contains the details 
>>about that?
>>
>>Benoit
>>
>
> This is valid for both OMAP3 and OMAP4. You can find this in 24.1.5.4 section
> With different modes. When not used with any application the mode has to be programmed 
> is force idle and force standby. What I observed is that without this USB was 
> blocking the coreoff.
>
> http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf 
>

For the next rev, please include links to public docs in the changelog.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
