From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/8] AI TB: HID file for Always Innovating OMAP3-based
	Touch Book keyboard
Date: Wed, 18 Nov 2009 22:30:41 -0800
Message-ID: <20091119063040.GA3010@core.coreip.homeip.net>
References: <1258228079.16065.17.camel@runt> <1258345850.9089.21.camel@gregoire-laptop> <1258599474.8001.36.camel@gregoire-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258599474.8001.36.camel@gregoire-laptop>
Sender: linux-input-owner@vger.kernel.org
To: Gregoire Gentil <gregoire@gentil.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Gregoire,

On Wed, Nov 18, 2009 at 06:57:54PM -0800, Gregoire Gentil wrote:
> +
> +int touchbook_create_sysfs(struct hid_device *hdev)
> +{
> + int i;
> + int r;
> +
> + for (i = 0; i < ARRAY_SIZE(touchbook_hid_attrs); i++) {
> + r = device_create_file(&hdev->dev,
> + &touchbook_hid_attrs[i]);
> +
> + if (r) {
> + dev_err(&hdev->dev, "failed to create sysfs file\n");
> + return r;
> + }
> + }
> +

You just reimplemented sysfs attribute group.

-- 
Dmitry
