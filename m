From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC/PATCH 0/3] OMAP3 I2C/SCCB support
Date: Tue, 26 Jun 2012 18:56:16 +0200
Message-ID: <20120626185616.7fafc53b@endymion.delvare>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CAGGh5h3WLmQbDyoh8GbydxXQJ81DrVmeZK3Xh13HmHv4cxOs_g@mail.gmail.com>
	<2898283.yhxlxrlhzg@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2898283.yhxlxrlhzg@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: jean-philippe francois <jp.francois-JOfcSVQZ0GHQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Salut Laurent,

On Tue, 26 Jun 2012 18:20:33 +0200, Laurent Pinchart wrote:
> It might be a good idea to implement i2c_smbus_*-like functions for 16-bit 
> register addresses in the I2C core, they could be reused across drivers.

Except that they would preferably not be called i2c_smbus_*, not being
part of the SMBus subset nor being commonly implemented by SMBus-only
controllers. Finding a proper name for these helpers function might be
tough, as may be figuring out which ones you really want to implement
and which ones aren't worth it.

Also note that this is more or less what regmap is trying to do, so you
may want to check in that direction (see drivers/base/regmap) first.

-- 
Jean Delvare
