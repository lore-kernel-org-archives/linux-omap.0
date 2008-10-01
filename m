From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Wed, 1 Oct 2008 16:46:14 +0300
Message-ID: <94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
	 <200809271645.20782.david-b@pacbell.net> <20080928031411.GF8468@frodo>
	 <200809272216.14672.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:46624 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYJANqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 09:46:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so596651rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Oct 2008 06:46:14 -0700 (PDT)
In-Reply-To: <200809272216.14672.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Sun, Sep 28, 2008 at 8:16 AM, David Brownell <david-b@pacbell.net> wrote:
> On Saturday 27 September 2008, Felipe Balbi wrote:
>> On Sat, Sep 27, 2008 at 04:45:20PM -0700, David Brownell wrote:
>> > On Saturday 27 September 2008, Felipe Balbi wrote:
>> > > We need something like the patch below (I can't find a substitute
>> > > to twl4030_set_gpio_edge_ctrl and twl4030_set_gpio_debounce):
>> >
>> > Something like that, yes.  I have other patches queued up though.
>> >
>> > And meanwhile, your build seems goofed ... fix that first.
>>
>> Yeah, it only happens when both mmc and twl4030-gpio are built as
>> modules. Still sounds weird since we have EXPORT_SYMBOL() for those
>> twl-specific crap.
>
> Don't yet build twl4030 as a module.  The vmlinux object can't
> link against symbols in other objects.  ;)
>
> As I noted, the modular option is for build testing; when this
> goes to mainline, this code should be able to build on most any
> platform.  (Not just OMAP; not just ARM.)  I don't think any of
> the OMAP boards which actually use this code will be able to use
> that as a module, though.
>
> When hsmmc.c behaves again, I've got patches to get rid of its
> use of those twl-specific symbols.  Then that linkage issue
> will go away.

Hmm, I'm seeing two different configs:
CONFIG_TWL4030_GPIO
CONFIG_GPIO_TWL4030

I guess the defconfigs are wrong.

-- 
Felipe Contreras
