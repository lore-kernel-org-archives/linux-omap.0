From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: stable kernel version
Date: Mon, 19 Oct 2009 18:31:44 +0200
Message-ID: <4ADC9470.4080403@tzi.de>
References: <4AD58D69.2080303@tzi.de> <20091014172656.GJ12700@atomide.com> <4AD60CEE.8000204@tzi.de> <20091014193324.GK12700@atomide.com> <4AD88BBD.9010602@tzi.de> <20091016154051.GE12576@atomide.com> <4ADC7476.9090208@tzi.de> <FCCFB4CDC6E5564B9182F639FC35608702FA174DCE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:37266 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756876AbZJSQcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 12:32:21 -0400
Received: from [192.168.101.170] (te52.informatik.uni-bremen.de [134.102.219.52])
	by informatik.uni-bremen.de (8.14.3/8.14.3) with ESMTP id n9JGViRl025819
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 18:31:47 +0200 (CEST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA174DCE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pandita, Vikram schrieb:
> Here's the problem:
> <3>HS USB OTG: no transceiver configured
> <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -19
>
> Depending on your board, you will have to define the transceiver for MUSB.
> It could be TWL4030 or NO-transceiver...
>   
I got an Gumstix Overo Earth so which one would it be then ?

I tried one kernel, with only NOOP,
and one with all three options enabled,
same result any time (crash).
> Drivers -> USB -> (last options) *** OTG and related infrastructure ***
>
> Or do u want to disable USB to start with !!
>   
Actually USB is the feature why I started compiling a new kernel
in the fist place ;-)


Regards
    Janosch
