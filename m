From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Mon, 28 Jun 2010 19:16:55 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270191FFE@dbde02.ent.ti.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
 <20100628132912.GG2822@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270191FE9@dbde02.ent.ti.com>
 <20100628134209.GH2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100628134209.GH2822-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org] 
>Sent: Monday, June 28, 2010 7:12 PM
>To: Kalliguddi, Hema
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Felipe Balbi
>Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>omap_device_build for device registration.
>
>* Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org> [100628 16:26]:
>>  
>> 
>> >-----Original Message-----
>> >From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org] 
>> >Sent: Monday, June 28, 2010 6:59 PM
>> >To: Kalliguddi, Hema
>> >Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Felipe Balbi
>> >Subject: Re: [PATCH 4/4]usb : musb:USB driver using 
>> >omap_device_build for device registration.
>> >
>> >* Hema HK <hemahk-l0cyMroinI0@public.gmane.org> [100628 15:12]:
>> >> -
>> >> -	/*
>> >> -	 * REVISIT: This line can be removed once all the 
>> >platforms using
>> >> -	 * musb_core.c have been converted to use use clkdev.
>> >> -	 */
>> >> -	musb_plat.clock = "ick";
>> >
>> >This comment is still valid, please don't remove it.
>> This is still there. It is moved below under else.
>
>Not in the patch you posted?
>

-	musb_plat.clock = "ick";
-	musb_plat.board_data = board_data;
-	musb_plat.power = board_data->power >> 1;
-	musb_plat.mode = board_data->mode;
-	musb_plat.extvbus = board_data->extvbus;
-
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+	char oh_name[MAX_OMAP_MUSB_HWMOD_NAME_LEN];
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct platform_device *pdev;
+	struct device	*dev;
+	int l, bus_id = -1;
+	struct musb_hdrc_platform_data *pdata;
+
+	l = snprintf(oh_name, MAX_OMAP_MUSB_HWMOD_NAME_LEN,
+						"usb_otg_hs");
+	WARN(l >= MAX_OMAP_MUSB_HWMOD_NAME_LEN,
+	"String buffer overflow in MUSB device setup\n");
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+	} else {
+		musb_plat.clock = "ick";
+		musb_plat.board_data = board_data;
+		musb_plat.power = board_data->power >> 1;
+		musb_plat.mode = board_data->mode;
+		pdata = &musb_plat;

It is there in the patch I posted.only the comment is being removed. You are refering the comment also? 

Regards,
Hema
>Tony
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
