From: Tony Lindgren <tony@atomide.com>
Subject: Re: LED backlight on Droid 4 and others
Date: Sun, 5 Jan 2020 12:24:49 -0800
Message-ID: <20200105202449.GC5885@atomide.com>
References: <20200105183202.GA17784@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200105183202.GA17784@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, agx@sigxcpu.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, jjhiblot@ti.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200105 18:32]:
> Hi!
> 
> It would be good to get LED backlight to work in clean way for 5.6
> kernel.

I agree, this is badly needed for many devices.

> [If you have an idea what else is needed, it would be welcome; it
> works for me in development tree but not in tree I'd like to
> upstream.]

I have some version of these patches working with modified dts in my
droid4-pending-v5.4 branch git branch, maybe try to diff against that.

Regards,

Tony
