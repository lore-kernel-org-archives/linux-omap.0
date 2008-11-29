From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] v4l2_device/v4l2_subdev: final (?) version
Date: Sat, 29 Nov 2008 12:20:47 -0800
Message-ID: <200811291220.47542.david-b@pacbell.net>
References: <200811291852.41794.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:41296 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752103AbYK2UUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Nov 2008 15:20:49 -0500
In-Reply-To: <200811291852.41794.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@skynet.be>

On Saturday 29 November 2008, Hans Verkuil wrote:
> +void v4l2_device_register(struct device *dev, struct v4l2_device *v4=
l2_dev)
> +{
> +=A0=A0=A0=A0=A0=A0=A0BUG_ON(!dev || !v4l2_dev || dev_get_drvdata(dev=
));
>=20

Ouch.  Better to return -EINVAL, like most register() calls,
than *ever* use a BUG_ON() for bad parameters.  Same applies
every other place you use BUG_ON, from a quick scan ...

=46or the unregister() paths a WARN() would be fair.  Again,
any time you're tempted to use BUG() or BUG_ON(), you need
to re-think.  It's hardly ever the right thing to do.  Just
report the error and continue; callers should check, and
clean up if something went wrong.


> +EXPORT_SYMBOL(v4l2_device_register);

This may be a nit, but I wonder why not EXPORT_SYMBOL_GPL,
which seems to be more correct in this case.


Another quasi-style point:  v4l2-device.s and v4l-subdev.c
are so small, and conceptually related, that I'd be tempted
to have one file not two.  Ditto their headers.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
