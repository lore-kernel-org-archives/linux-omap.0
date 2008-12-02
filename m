From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed [V4]
Date: Tue, 2 Dec 2008 11:29:32 -0800
Message-ID: <200812021129.33434.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1228232142-11934-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:25260 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753225AbYLBT3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 14:29:35 -0500
In-Reply-To: <1228232142-11934-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: video4linux-list@redhat.com, linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>, Karicheri Muralidharan <m-karicheri2@ti.com>

On Tuesday 02 December 2008, hvaibhav@ti.com wrote:
> +static int __init tvp514x_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +
> +=A0=A0=A0=A0=A0=A0=A0err =3D i2c_add_driver(&tvp514x_i2c_driver);
> +=A0=A0=A0=A0=A0=A0=A0if (err) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR "Failed=
 to register " MODULE_NAME ".\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return err;
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}

Just do the normal

	return i2c_add_driver(...);



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
