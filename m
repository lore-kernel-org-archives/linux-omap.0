From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Fri, 14 Dec 2012 14:13:07 +0200
Message-ID: <CANOLnONT=dFx581WFRn_b9Q=ngJpfzx+A56b-7po4xVZVqisyw@mail.gmail.com>
References: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63918 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab2LNMNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 07:13:09 -0500
In-Reply-To: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ian Coolidge <iancoolidge@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, balbi@ti.com, felipe.contreras@gmail.com, icoolidge@trellisware.com

On Fri, Dec 14, 2012 at 11:53 AM, Ian Coolidge <iancoolidge@gmail.com> =
wrote:
> we find that with about a 2% chance, the gadget comes up in some kind=
 of firmware failed state, driving VBUS.
> In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
> I understand this to be indicative of MUSB thinking it is in host mod=
e, which agrees with the driven VBUS.
> Further, in this state, I found that usually, there was one interrupt=
 from twl4030_usb, but NO interrupts from musb-hdrc.

I'm also also often seeing this and don't know any workaround except
powercycling the board :(
This was kind or relieved for me after I changed it to deinit musb on
shutdown/reset (3.3 should have that patch merged), however if you
randomly reset the board, there is still something like 30-50% chance
musb will come up dead, and on proper reset it's still something like
5% chance like you reported.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
