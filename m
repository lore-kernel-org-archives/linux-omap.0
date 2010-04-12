From: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: RE: [PATCH] Add OHCI USB platform init
Date: Mon, 12 Apr 2010 11:11:32 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343A69@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <1271046713-10475-1-git-send-email-viral.mehta@lntinfotech.com>,<000101cada01$ae89f660$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <000101cada01$ae89f660$808918ac-wD+IZp/g4/2mHdYHvhjUOg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik <x0082077-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


>> +static struct omap_usb_config sdp2430_usb_config __initdata = {
>> +       .otg            = 1,
>> +#ifdef  CONFIG_USB_GADGET_OMAP
>> +       .hmc_mode       = 0x0,
>> +#elif   defined(CONFIG_USB_OHCI_HCD) ||
>> defined(CONFIG_USB_OHCI_HCD_MODULE)
>> +       .hmc_mode       = 0x1,
>> +#endif
>> +       .pins[0]        = 3,
>> +}

>Use tabs instead of spaces.


tabs only used. even checkpatch says no warning/error.

[root@viral my_git]# /home/omap2430/mod.linux-2.6.33.1/scripts/checkpatch.pl 0002-Add-I2C-bus-1-initialisation.patch
total: 0 errors, 0 warnings, 18 lines checked

0002-Add-I2C-bus-1-initialisation.patch has no obvious style problems and is ready for submission.

I assume its your mailer that mangled the things. Sent through git-send-email and so that should not cause a problem, too. If some one else also points out, will try to resend.

Thanks,
Viral

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
