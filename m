From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] usb: musb: omap: fix crash when musb glue (omap)
 gets initialized
Date: Thu, 22 Mar 2012 14:39:18 -0700
Message-ID: <20120322213918.GA11352@kroah.com>
References: <1332412545-32396-1-git-send-email-kishon@ti.com>
 <20120322143351.GB19835@kroah.com>
 <CAAe_U6JwPbzgn2M+J20rZvoDdmOuS_YOxVitDWPM_wyJmdbcdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53182 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2CVVjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 17:39:22 -0400
Received: by gghe5 with SMTP id e5so2247421ggh.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 14:39:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAe_U6JwPbzgn2M+J20rZvoDdmOuS_YOxVitDWPM_wyJmdbcdg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, stable@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Mar 23, 2012 at 03:04:04AM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi Greg,
>=20
> On Thu, Mar 22, 2012 at 8:03 PM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > On Thu, Mar 22, 2012 at 04:05:45PM +0530, Kishon Vijay Abraham I wr=
ote:
> >> Upstream Commit: 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
> >> Upstream Kernel Tag: v2.6.38-rc5-94-g7acc619
> >
> > <snip>
> >
> > <formletter>
> >
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree. =A0Please read Documentation/stable_kernel_rule=
s.txt
> > for how to do this properly.
> >
> > </formletter>
>=20
> I really couldn't get what I'm missing after reading the
> Documentation/stable_kernel_rules.txt :-( Can you kindly let me know
> what I'm missing here?

Read the version of that file in the 3.3 kernel release, it should
explain what you are forgetting (hint, do you really want it applied to
the 2.4 kernel tree?)

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
