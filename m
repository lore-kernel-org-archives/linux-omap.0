From: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: RE: USB on omap2430
Date: Mon, 5 Apr 2010 19:32:06 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343A36@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
 <20100329204159.GC31402@nokia.com>
 <70376CA23424B34D86F1C7DE6B997343023C4E201B@VSHINMSMBX01.vshodc.lntinfotech.com>,<3bd3371a3ea8aa8fb53b62dbe99169e0@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3bd3371a3ea8aa8fb53b62dbe99169e0-WEDJutINlwSqfKURHDCIgFDQ4js95KgL@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

>>  static void __exit isp_exit(void)
>>  {
>>
>>
>>
>> After adding the above code, isp1301's probe is called but that fails
>> before it does otg_set_transceiver()
>> And I am debugging further on that path.

>ok, cool. When you get that done, please send a cleaned up
>diff with your signed-off-by line so it can be integrated.

I continued debugging further. It fails during USB initialisation.
More specifically, in omap_otg_init() function in arch/arm/plat-omap/usb.c
It gives a crash dump on the first line itself
syscon = omap_readl(OTG_SYSCON_1) & 0xffff;

I feel like I need to make some board (OMAP2430) specific changes to this file.
I am not able to progress further. Any pointers will be appreciated.

Apart from that, can I submit the 3 patches that we discussed earlier ?
(http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg25932.html)
These will not make FS USB functional on OMAP2430 but these changes are anyway necessary.

--
Viral


http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg25932.html

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
