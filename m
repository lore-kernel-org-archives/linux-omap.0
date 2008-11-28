From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Fri, 28 Nov 2008 08:52:21 -0800
Message-ID: <200811280852.22711.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:28928 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752133AbYK1QwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 11:52:24 -0500
In-Reply-To: <1227876228-16553-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, davinci-linux-open-source-bounces@linux.davincidsp.com, linux-omap@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

On Friday 28 November 2008, hvaibhav@ti.com wrote:
> +=A0=A0=A0=A0=A0=A0=A0for (; next->token !=3D TOK_TERM; next++) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (next->token =3D=3D =
TOK_DELAY) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
schedule_timeout(msecs_to_jiffies(next->val));

			msleep(next->val);

would be clearer and more conventional.


> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
continue;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}


> +static int
> +tvp514x_probe(struct i2c_client *client, const struct i2c_device_id =
*id)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct tvp514x_decoder *decoder =3D &tvp514x_de=
v;
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +
> +=A0=A0=A0=A0=A0=A0=A0if (i2c_get_clientdata(client))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> +

When no driver is bound to the client, clientdata is undefined.
So just strike that ... you can rely on probe() only being
called on un-bound drivers.


I still don't see any post-reset chip init being done.  The data
sheets for the tvp5146 and tvp5147 say that after reset, some
commands must be sent ... that's not being done here.  Are you
assuming perhaps tvp5146m2 and tvp5147m1, although they are not
listed as chips supported by this driver?  (That's a repeat of
a previous review comment, which garnered no response, so the
$SUBJECT is inaccurate:  at least some review comments have not
yet been addressed...)

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
