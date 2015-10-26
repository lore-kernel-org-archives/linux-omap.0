From: Adam Ford <adam.ford-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Question about TI Shared Transport
Date: Mon, 26 Oct 2015 15:10:53 +0000
Message-ID: <4efd97bfa35247edbad2474100901d32@EDPR-MAIL01.logicpd.com>
References: <8a0b6861e04142798bc4469ee47aca65@EDPR-MAIL01.logicpd.com>
 <562E3EA7.7010000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562E3EA7.7010000-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Grygorii Strashko' <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "'gigi.joseph-l0cyMroinI0@public.gmane.org'" <gigi.joseph-l0cyMroinI0@public.gmane.org>, "'marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org'" <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "'devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "'linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The revert appears in the 4.2.4 log as well, so it happened before 4.2 was released. From what I can see, that ti-st directory hasn't changed between 4.2.4 and the 4.3.

-----Original Message-----
From: Grygorii Strashko [mailto:grygorii.strashko-l0cyMroinI0@public.gmane.org] 
Sent: Monday, October 26, 2015 9:55 AM
To: Adam Ford <adam.ford-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>; 'gigi.joseph-l0cyMroinI0@public.gmane.org' <gigi.joseph-l0cyMroinI0@public.gmane.org>; 'marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org' <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>; 'devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org' <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>; 'linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org' <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: Question about TI Shared Transport

On 10/26/2015 03:58 PM, Adam Ford wrote:
> Gigi,
>
> I am working on modifying the DTS and DTSI files for the LogicPD Torpedo which Tony added in Kernel 4.2
>
> There was a flurry of activity earlier this year regarding device tree bindings for the shared transport and using the Bluetooth with it as seen here:  https://patchwork.ozlabs.org/patch/464777/
>
> I was able to get the Logic PD device to work with Bluetooth and the Shared Transport using the instructions found http://processors.wiki.ti.com/index.php/Shared_Transport_Driver#Device_Tree_kernel
>
> When I attempted to submit patches for the btwilink, the check script noted that the documentation for btwlink and shared transport bindings were missing.  It seems like there might be a new way to attach the BTWILINK to the UART, but I wasn't sure if there was a better solution available yet.
>
> I also noticed that using the shared transport mechanism in 4.2.x worked, but trying the same method in 4.3 resulted in a segmentation fault.  Does anyone have any updated instructions for the proper way to use the BTWILINK?
>

It is not worked because OF support was reverted:
c0bd1b9 Revert "ti-st: add device tree support"


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
