From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Mon, 2 May 2011 14:54:08 +0300
Message-ID: <20110502115408.GC2529@legolas.emea.dhcp.ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
 <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
 <20110502093815.GQ2529@legolas.emea.dhcp.ti.com>
 <BANLkTi=kH02P9GFo6wmPpRGr=L582DEp0A@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=kH02P9GFo6wmPpRGr=L582DEp0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 02, 2011 at 05:01:05PM +0530, Munegowda, Keshava wrote:
> On Mon, May 2, 2011 at 3:08 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > On Thu, Apr 21, 2011 at 07:52:42PM +0530, Keshava Munegowda wrote:
> >> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >>
> >> The gpio of EHCI phy should be 0 instead of 1;
> >> This fixes the hub enumeration issue in beagle xm board.
> >>
> >> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >
> > applied, thanks
> >
> > --
> > balbi
> 
> Thanks balbi
> 
> but ,.his patch is was made by Juergen Kilb ( patch description  and link is
> given below); But I was not aware of it and reinvented wheel with
> beagle-xm board :(
> 
> So, Juergen Kilb is the first author of this patch.
> 
> Here is the link :
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg48215.html
> 
>   omap:usbhs:Fixed gpio polarity of gpio USB-phy reset
> 
>     With commit 19403165 a main part of ehci-omap.c moved to
>     drivers/mfd/omap-usb-host.c created by commit 17cdd29d.
>     Due to this reorganisation the polarity used to reset the
>     external USB phy changed and USB host doesn't recognize
>     any devices.
> 
>     Signed-off-by: Juergen Kilb <J.Kilb-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>

I sent a pull request to Greg with that patch in, so it looks like
Samuel also didn't send this patch before. Can you reply to the pull
request I sent saying that this patch should be dropped just so Greg
knows and I recreate the branch and send another pull request ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
