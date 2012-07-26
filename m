From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 02/11] usb: musb: kill global and static for multi
 instance
Date: Thu, 26 Jul 2012 08:29:45 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF877@DBDE01.ent.ti.com>
References: <1343218326-30610-1-git-send-email-ajay.gupta@ti.com>
 <20120726074057.GH29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF790@DBDE01.ent.ti.com>
 <20120726082459.GP29029@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120726082459.GP29029-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > > On Wed, Jul 25, 2012 at 05:42:06PM +0530, Ajay Kumar Gupta wrote:
> > > > @@ -240,20 +238,24 @@ int __devinit musb_init_debugfs(struct musb
> *musb)
> > > >  	struct dentry		*root;
> > > >  	struct dentry		*file;
> > > >  	int			ret;
> > > > +	char			name[10];
> > > >
> > > > -	root = debugfs_create_dir("musb", NULL);
> > > > +	sprintf(name, "musb%d", musb->id);
> > > > +	root = debugfs_create_dir(name, NULL);
> > >
> > > I told you to use dev_name(musb) for a reason. See what happens when
> > > you use dev_name(musb);
> > >
> > > Do you not think about the other users of this driver ? Do you not
> > > know what's the ID on platform_devices which "don't have an ID" ??
> >
> > We are now using musb_ida for all glue layers so '-1' issue will not come.
> 
> true.
> 
> > Still if we can manage without 'id' then better to do that way.
> 
> just make sure to notice that directory name will "musb.0".

Sure.

Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
