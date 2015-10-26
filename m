From: Adam Ford <adam.ford-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Subject: Question about TI Shared Transport
Date: Mon, 26 Oct 2015 13:58:48 +0000
Message-ID: <8a0b6861e04142798bc4469ee47aca65@EDPR-MAIL01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'gigi.joseph-l0cyMroinI0@public.gmane.org'" <gigi.joseph-l0cyMroinI0@public.gmane.org>, "'marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org'" <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "'devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "'linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Gigi,

I am working on modifying the DTS and DTSI files for the LogicPD Torped=
o which Tony added in Kernel 4.2

There was a flurry of activity earlier this year regarding device tree =
bindings for the shared transport and using the Bluetooth with it as se=
en here:  https://patchwork.ozlabs.org/patch/464777/

I was able to get the Logic PD device to work with Bluetooth and the Sh=
ared Transport using the instructions found http://processors.wiki.ti.c=
om/index.php/Shared_Transport_Driver#Device_Tree_kernel

When I attempted to submit patches for the btwilink, the check script n=
oted that the documentation for btwlink and shared transport bindings w=
ere missing.  It seems like there might be a new way to attach the BTWI=
LINK to the UART, but I wasn't sure if there was a better solution avai=
lable yet.

I also noticed that using the shared transport mechanism in 4.2.x worke=
d, but trying the same method in 4.3 resulted in a segmentation fault. =
 Does anyone have any updated instructions for the proper way to use th=
e BTWILINK?

Thank you,
adam

Adam Ford =A0//=A0 Sr. Apps Engineer
Logic PD
411 Washington Ave N, Suite 400=A0=20
Minneapolis, MN 55401
M // 612.246.6391
T // 612.436.5117x7113
=46 // 612.672.6489
adam.ford-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org=A0=20
Logic PD // Twitter // LinkedIn

NOTICE: Important disclaimers and limitations apply to this email.
Please see this web page for our disclaimers and limitations:
http://logicpd.com/email-disclaimer/


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
