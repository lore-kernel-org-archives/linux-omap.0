From: ndno72-omap@yahoo.com
Subject: Re: No audio support for BeagleBoard in Latest GIT tree?
Date: Tue, 27 Jan 2009 02:37:30 -0800 (PST)
Message-ID: <636109.62555.qm@web81102.mail.mud.yahoo.com>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org> <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org> <200901241230.34735.david-b@pacbell.net> <bd7b27490901250616q2363c5b4wf422d32831bd3638@mail.gmail.com> <258288.30602.qm@web81108.mail.mud.yahoo.com> <20090127115540.b7c5e004.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web81102.mail.mud.yahoo.com ([68.142.199.94]:21453 "HELO
	web81102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753009AbZA0Khb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2009 05:37:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, "linux-omap@vger.kernel.orgList" <linux-omap@vger.kernel.org>


> > 2) The BeagleBoard uses the twl4030 device for its audio (among other things); 
> for our OMAP3 custom board, we're not using that, we're going to continue use 
> the AIC33 codec (like what we used on our Davinci custom board).  Is adding 
> support for the AIC33 codec as simple as enabling that option in the OMAP3 GIT 
> kernel configuration under ALSA?  Or do I have to do a lot of porting?  If so, 
> what is the best approach, i.e. porting the AIC33 initialization/driver code for 
> mthe Davinci GIT kernel into OMAP3 GIT kernel?
> 
> With ALSA System on Chip (ASoC) porting is pretty simple. There is
> already driver for AIC33 (sound/soc/codecs/tlv320aic3x.c), ASoC OMAP
> platfrom drivers (sound/soc/omap) and also machine drivers using AIC33
> (sound/soc/omap/n810.c and sound/soc/davinci/davinci-evm.c).
> 
> So what you need is basically to write your own machine driver using
> mostly copy-paste approach.
> 
> > 3) Is OSS audio API no longer supported?  Our existing application uses the 
> OSS audio API; the latest kernel seems to only support ALSA; is OSS emulation 
> (on top of ALSA) working and/or reliable?
> 
> At least some few OSS applications I have tried were working fine with
> OSS emulation.
> 

Thanks for the advice and pointers.  Hopefully, when I get my hands dirty in a few weeks and I get into troubles, people like you on this board can help.

Regards,
Andy

