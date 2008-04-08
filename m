From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod will be reset several times in usb-storage transcation
Date: Tue, 8 Apr 2008 12:00:16 +0800
Message-ID: <386072610804072100y71848d60r3e0ea63841f9ef0f@mail.gmail.com>
References: <386072610804070316i15ee172cue9c0cc5803f9a934@mail.gmail.com>
	 <5bd10b9010c8281ff117f7ebb02f7d39@felipebalbi.com>
	 <200804070903.11354.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:33617 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbYDHEAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 00:00:17 -0400
Received: by el-out-1112.google.com with SMTP id v27so1342573ele.17
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 21:00:16 -0700 (PDT)
In-Reply-To: <200804070903.11354.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Apr 8, 2008 at 12:03 AM, David Brownell <david-b@pacbell.net> wrote:
> On Monday 07 April 2008, Felipe Balbi wrote:
>  > > e) So I hacked the usb-storage driver code, the Linux host on Blackfin
>  > > will not wait for the 2nc CSW. Then this bug is gone.
>  > >
>  > > This is just a workaround for that, it should not be the right way.
>  > > Does anyone here meet this issue before, on Davinci or OMAP?
>  > > We always need a real fix, thanks a lot
>  >
>  > I've seen this already with n800/n810. It came up after a merge with
>  > mainline that changed usb subsystem a bit.
>
>  Which merge was that?
>
>  My guess would be that the host side fault reporting
>  changes (short packet?) didn't get fully reflected in
>  the MUSB code.
>

Sorry, I did not fully understand here. I guess it the error return
value issue in the 2.6.24 or later kernel.
I got a patch for that, but not sure whether it is right

--
Index: drivers/usb/musb/musb_host.c
===================================================================
--- drivers/usb/musb/musb_host.c        (revision 4555)
+++ drivers/usb/musb/musb_host.c        (working copy)
@@ -422,7 +422,11 @@ musb_advance_schedule(struct musb *musb,
                qh = hw_ep->in_qh;
        else
                qh = hw_ep->out_qh;
-       qh = musb_giveback(qh, urb, 0);
+
+       if (urb->status == -EINPROGRESS)
+               qh = musb_giveback(qh, urb, 0);
+       else
+               qh = musb_giveback(qh, urb, urb->status);

        if (qh && qh->is_ready && !list_empty(&qh->hep->urb_list)) {
                DBG(4, "... next ep%d %cX urb %p\n",
--

But the original bug is still here, unless we do workaround in the
usb-storage code as my patch does.

>  How is "usbtest" behaving?  I'm not sure that would
>  show errors like this, but at least it'd be good to
>  know that's not an issue.
>

I did not use usbtest on MUSB host, but plan to do it in our testing machine.

Thanks
-Bryan
