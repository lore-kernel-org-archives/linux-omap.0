From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: musb: move musb debugfs entry under usb debugfs root dir
Date: Sat, 28 Aug 2010 10:56:23 +0800
Message-ID: <AANLkTimcLBs_DZyUp_5+jfanqcpXknUDnHm5X0vYGnz5@mail.gmail.com>
References: <1282923939-14872-1-git-send-email-tom.leiming@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1CBD0@dbde02.ent.ti.com>
	<20100827171642.GB19775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100827171642.GB19775-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/8/28 Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>:
> On Fri, Aug 27, 2010 at 10:34:45PM +0530, Gadiyar, Anand wrote:
>> tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> >
>> > From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >
>> > All hcd's debugfs entries are under usb debugfs root dir already,
>> > so musb should not be a exception.
>> >
>> > Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > ---
>> > =A0drivers/usb/musb/musb_debugfs.c | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/mu=
sb_debugfs.c
>> > index c79a5e3..b19c31c 100644
>> > --- a/drivers/usb/musb/musb_debugfs.c
>> > +++ b/drivers/usb/musb/musb_debugfs.c
>> > @@ -257,7 +257,7 @@ int __init musb_init_debugfs(struct musb *musb=
)
>> > =A0 =A0 struct dentry =A0 =A0 =A0 =A0 =A0 *file;
>> > =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret;
>> >
>> > - =A0 root =3D debugfs_create_dir("musb", NULL);
>> > + =A0 root =3D debugfs_create_dir("musb", usb_debug_root);
>> > =A0 =A0 if (IS_ERR(root)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(root);
>> > =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>>
>> Hi,
>>
>> This will not work when you do not have USB Host support enabled in
>> your kernel.
>
> Then we should move the creation of usb_debug_root out into somewhere
> that will work for both types of systems, right? =A0Now where that mi=
ght
> be, I can't tell at the moment...

Seems a little difficult to find a place to create usb_debug_root which=
 may
support both usb host and device.

USB gadget framework doesn't depend on usbcore.

So please ignore the patch now, thanks.

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
