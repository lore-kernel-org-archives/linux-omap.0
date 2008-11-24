From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Mon, 24 Nov 2008 02:06:37 -0800
Message-ID: <200811240206.38924.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1227280923-31654-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:27049 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868AbYKXKGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 05:06:41 -0500
In-Reply-To: <1227280923-31654-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Brijesh Jadav <brijesh.j@ti.com>

On Friday 21 November 2008, hvaibhav@ti.com wrote:
> +static const struct i2c_device_id tvp514x_id[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{MODULE_NAME, 0},
> +=A0=A0=A0=A0=A0=A0=A0{},
> +};

Don't do that.  Instead:

	{ "tvp5146", 0 },
	{ "tvp5147", 0 },

and so on.  Maybe pass a flag there to help determine which
chip reset/init message sequence to use.  (Which, hmm, I did
not see in this code, although the data sheets are clear
that the '46 needs 12 writes and the '47 needs 18 ...)  Or
tell if the extra '46 registers are available, etc.


> +late_initcall(tvp514x_init);

Why is this "late" instead of normal module_init()?
It's unusual for I2C...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
