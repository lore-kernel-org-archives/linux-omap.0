From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-probe in 2.6.28 returns -EOPNOTSUPP
Date: Tue, 20 Jan 2009 14:04:27 +0100
Message-ID: <20090120140427.3c5a92c3@hyperion.delvare>
References: <f502236f0901200450n4e943c63n7da6ac815efe4aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f502236f0901200450n4e943c63n7da6ac815efe4aca-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Jan 2009 18:20:58 +0530, pramod gurav wrote:
> Hi All
> I am trying to port the i2c client drivers from linux-omap-2.6.26 to 2.6.28.
> The i2c client drivers are old styled. The i2c-probe function called by
> attach_adapter function returns -EOPNOTSUPP.
> This states adapter does not support SMBUS_QUICK command.
> Same driver on linux-omap-2.6.26 works well.
> The omap_i2c_func in i2c-omap.c driver doesn't seem to be returning
> this support.
> 
> What changes have gone into i2c-omap driver that are causing i2c-probe
> function to return this error value?

The i2c-omap bus driver in mainline has never supported the SMBus quick
command.

Anyway old-style i2c chip drivers must be converted to new-style, as
support for old style is deprecated and will be removed soon. So your
best chance is to do just that. This really isn't difficult.

-- 
Jean Delvare
