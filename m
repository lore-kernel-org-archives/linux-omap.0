From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] i2c-omap: always send stop after nack
Date: Tue, 20 Aug 2013 19:39:31 +0300
Message-ID: <52139BC3.8030907@ti.com>
References: <51E50217.1000507@yahoo.es> <20130716090300.GG8880@arwen.pp.htv.fi> <51E5137B.7000302@yahoo.es> <20130716094212.GL8880@arwen.pp.htv.fi> <51E527F7.4080007@ti.com> <20130716112746.GN8880@arwen.pp.htv.fi> <51E537A4.40300@ti.com> <20130716130058.GD15036@arwen.pp.htv.fi> <51E57211.2040001@yahoo.es> <20130819121123.GA4540@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130819121123.GA4540@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hein Tibosch <hein_tibosch@yahoo.es>, balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/19/2013 03:11 PM, Wolfram Sang wrote:
> Hi,
>
>>> Which means your original patch starts to make a lot more sense. I
>>> wonder is this is really what we should be doing though - breaking out
>>> of the loop, I mean.
>
> Yup, that is fine. I applied the old patch with Acks from Hein and
> Felipe to -next. Thanks!

Thanks.

>
>> It looks like TI's i2c-davinci will have the same problem as i2c-omap,
>> and will need the same change.
>
> Somebody up for this?
>

Regards,
-grygorii
