From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] usb: musb: omap: fix crash when musb glue (omap)
 gets initialized
Date: Thu, 22 Mar 2012 15:34:11 -0700
Message-ID: <20120322223411.GA32739@kroah.com>
References: <1332412545-32396-1-git-send-email-kishon@ti.com>
 <20120322143351.GB19835@kroah.com>
 <CAAe_U6JwPbzgn2M+J20rZvoDdmOuS_YOxVitDWPM_wyJmdbcdg@mail.gmail.com>
 <20120322213918.GA11352@kroah.com>
 <CAAe_U6J8hpGWAZPnfYOWuM=mVxW84cs=ajhdedBKx+pLXOSyhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41334 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab2CVWeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 18:34:15 -0400
Received: by pbcun15 with SMTP id un15so1943699pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 15:34:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAe_U6J8hpGWAZPnfYOWuM=mVxW84cs=ajhdedBKx+pLXOSyhw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, stable@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Mar 23, 2012 at 03:59:32AM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi Greg,
>=20
> On Fri, Mar 23, 2012 at 3:09 AM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > On Fri, Mar 23, 2012 at 03:04:04AM +0530, ABRAHAM, KISHON VIJAY wro=
te:
> >> Hi Greg,
> >>
> >> On Thu, Mar 22, 2012 at 8:03 PM, Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >> > On Thu, Mar 22, 2012 at 04:05:45PM +0530, Kishon Vijay Abraham I=
 wrote:
> >> >> Upstream Commit: 7acc6197b76edd0b932a7cbcc6cfad0a8a87f026
> >> >> Upstream Kernel Tag: v2.6.38-rc5-94-g7acc619
> >> >
> >> > <snip>
> >> >
> >> > <formletter>
> >> >
> >> > This is not the correct way to submit patches for inclusion in t=
he
> >> > stable kernel tree. =A0Please read Documentation/stable_kernel_r=
ules.txt
> >> > for how to do this properly.
> >> >
> >> > </formletter>
> >>
> >> I really couldn't get what I'm missing after reading the
> >> Documentation/stable_kernel_rules.txt :-( Can you kindly let me kn=
ow
> >> what I'm missing here?
> >
> > Read the version of that file in the 3.3 kernel release, it should
> > explain what you are forgetting (hint, do you really want it applie=
d to
> > the 2.4 kernel tree?)
>=20
> I actually intended this patch to be back-ported to previous releases
> which will have the issue. I'm not sure if it is right?

And what releases are those?

Hint, you need to tell us exactly what trees you want your patch applie=
d
to, otherwise we will just guess, and usually, incorrectly.

Be specific.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
