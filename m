From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() with sysfs_streq()
 in overlay_manager_store()
Date: Thu, 29 Jul 2010 11:26:52 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703060EADBE@dbde02.ent.ti.com>
References: <'> <1280298118-4295-1-git-send-email-archit@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F08@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EAB90@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A025@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EAC8F@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A20D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47800 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab0G2F5E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 01:57:04 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A20D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > 
> > > > > > -----Original Message-----
> > > > > > From: linux-omap-owner@vger.kernel.org 
> > > > > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > > > > Taneja, Archit
> > > > > > Sent: Wednesday, July 28, 2010 11:52 AM
> > > > > > To: tomi.valkeinen@nokia.com
> > > > > > Cc: linux-omap@vger.kernel.org; Taneja, Archit
> > > > > > Subject: [PATCH resend] OMAP: DSS2: Replace strncmp() with
> > > > > > sysfs_streq() in overlay_manager_store()
> > > > > > 
> > > > > > In the function overlay_manager_store, the length of the
> > > > > string buf is
> > > > > > used to comapre the 2 strings, there is a possibility
> > of false
> > > > > > positive match if buf is a prefix string of another manager.
> > > > > > 
> > > > > > The use of sysfs_streq() fixes this.
> > > > > > 
> > > > > > Signed-off-by: Archit Taneja <archit@ti.com>
> > > > > > ---
> > > > > >  drivers/video/omap2/dss/overlay.c |    2 +-
> > > > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/video/omap2/dss/overlay.c
> > > > > > b/drivers/video/omap2/dss/overlay.c
> > > > > > index 8233658..244dca8
> > > > > > --- a/drivers/video/omap2/dss/overlay.c
> > > > > > +++ b/drivers/video/omap2/dss/overlay.c
> > > > > > @@ -65,7 +65,7 @@ static ssize_t 
> overlay_manager_store(struct 
> > > > > > omap_overlay *ovl, const char *buf,
> > > > > >  		for (i = 0; i <
> > > > > > omap_dss_get_num_overlay_managers(); ++i) {
> > > > > >  			mgr = omap_dss_get_overlay_manager(i);
> > > > > >  
> > > > > > -			if (strncmp(buf, mgr->name, len) == 0)
> > > > > > +			if (sysfs_streq(buf, mgr->name))
> > > > > 
> > > > > [sp] sysfs_streq() ignores trailing newlines during
> > > comparison. So,
> > > > >      the possibility mentioned in the description still stays.
> > > > 
> > > > The aim is to compare one string which is a sysfs input and
> > > the other
> > > > which is in the kernel.
> > > > 
> > > > > 
> > > > >      I am not familiar with overall context; but
> > wouldn't srtcmp()
> > > > >      be the right choice? unless, of course, either of strings
> > > > >      being compared are not null terminated.
> > > > 
> > > > The sysfs input will have a newline and null at the end
> > whereas the
> > > > other string will only have null, strcmp will fail when
> > we want the
> > > > two strings to match.
> > > > 
> > > > Eg. Sysfs input "lcd\n\0"
> > > > Kernel string "lcd\0"
> > > > 
> > > > strcmp will fail here
> > > 
> > > [sp] If the patch is intending to fix this condition, 
> then it isn't
> > >      evident from the description. You should consider 
> updating the
> > >      description.
> > 
> > The patch isn't intending to fix this condition, this condition 
> > doesn't occur at all in the existing code. I explained this to tell 
> > you why strcmp is a bad choice, the patch description tells why 
> > sysfs_streq is a better choice over strncmp.
> 
> [sp] Can you explain the real condition and how/why it can't 
> be handled
>      by strcmp()

Okay, the real condition (why this patch was sent) is this (please have a look
at the whole function body while reading the explanation):

The user enters "lcd" via sysfs input to change the overlay's manager to "lcd",
this input will be converted to "lcd\n\0", the function will try to
comapre this name with all the existing managers names. Consider the case where
buf (sysfs input) is "lcd\n\0" and mgr->name is "lcd2\0".

Now, len is calculated as 3 and is passed as the parameter to stncmp, in this
case, "lcd" and "lcd2" will match because only the first 3 characters are compared.
This is what I meant by buf being a prefix string of mgr->name.

This above is the condition which the patch tries to resolve.

strcmp will work like a charm here and ignore false positives, but it will generate
a false negative which didn't occur previously at all, an example:

If buf is "lcd\n\0" and mgr->name is "lcd\0" the code should match this, but strcmp
won't.

Hence, to prevent both false positives and false negatives sysfs_streq is used.

If you want to use strcmp, you will have to manually strip off the newlines.

I have also shared the patch link below which intrioduces sysfs_streq in the kernel
and explains why it has been introduced in the first place:

http://kerneltrap.org/mailarchive/git-commits-head/2008/5/1/1688084

I hope this explanation elaborates things clearly.

Thanks,

Archit
