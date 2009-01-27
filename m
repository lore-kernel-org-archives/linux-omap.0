From: ndno72-omap@yahoo.com
Subject: No audio support for BeagleBoard in Latest GIT tree?
Date: Tue, 27 Jan 2009 01:18:16 -0800 (PST)
Message-ID: <258288.30602.qm@web81108.mail.mud.yahoo.com>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org> <A73F0912-41CB-43F7-BE84-A4B91183B66B@beagleboard.org> <200901241230.34735.david-b@pacbell.net> <bd7b27490901250616q2363c5b4wf422d32831bd3638@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web81108.mail.mud.yahoo.com ([68.142.199.100]:26456 "HELO
	web81108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751968AbZA0JY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2009 04:24:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com
Cc: "linux-omap@vger.kernel.orgList" <linux-omap@vger.kernel.org>

Hi everyone,

Last week, I downloaded the 2.6.29-rc2 (http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tag;h=d31ce8060b0e875179ba5ca1d40475dc2a082cc7) and compiled it for the BeagleBoard.  Everything seems to run fine (I disabled video support because I don't use it).  However, there doesn't seem to be audio (twl4030 audio) support for the BeagleBoard; the default configuration (omap3_beagle_defconfig) doesn't enable audio and when I tried to enable ALSA, there's no option for the twl4030 driver.  Is audio not yet supported in the last GIT tree?  What the latest tag/tree (v2.6.28-omap1???) I should use that has audio support for the BeagleBoard.

I have a few more questions so maybe you guys can help me.  The questions I'm going to ask are mostly new and not already answered (I searched the group and coudn't find any answers); I'm sorry if any has been asked before and maybe you can point me in the right direction.  I'm new to the OMAP3 processor; I just started experimenting with the BeagleBoard a few weeks back (I also have TI Mistral OMAP3EVM board but I'm using the BeagleBoard since our OMAP3 custom board is based on the BeagleBoard).  For the last couple years, I worked on TI's Davinci processor; our project decided recently to go with the OMAP3 because it's more powerful and consumes less power.  For this reason, I have to port all our existing software to our new OMAP3 custom board.  For the Davinci processor, I used the 2.6
 .23 GIT version of the kernel (http://source.mvista.com/git/?p=linux-davinci-2.6.git) so I'm a little familiar with the kernel.  Here are some questions I have
 initially:

1) Is the X-loader really required?  Can the BeagleBoard just boot straight to u-boot?
2) The BeagleBoard uses the twl4030 device for its audio (among other things); for our OMAP3 custom board, we're not using that, we're going to continue use the AIC33 codec (like what we used on our Davinci custom board).  Is adding support for the AIC33 codec as simple as enabling that option in the OMAP3 GIT kernel configuration under ALSA?  Or do I have to do a lot of porting?  If so, what is the best approach, i.e. porting the AIC33 initialization/driver code for mthe Davinci GIT kernel into OMAP3 GIT kernel?
3) Is OSS audio API no longer supported?  Our existing application uses the OSS audio API; the latest kernel seems to only support ALSA; is OSS emulation (on top of ALSA) working and/or reliable?
4) How reliable is the DSP bridge driver mentioned on the wiki page?  On our Davinci board, we used TI's Code-Engine/DSP/BIOS DSPLINK driver to perform ARM-DSP IPC.  This past week, I was able to download TI's DSPLINK (now open source, https://www-a.ti.com/downloads/sds_support/targetcontent/link/index.html) and build it with the default BeagleBoard 2.6.22-18 kernel and got the examples to run fine.  I'm in the process of getting it to work with the latest OMAP3 GIT tree but I'm stuck now because I can't get the audio to work (my pre-first question).

OK, I think I've asked too many questions but hopefully someone can provide some advice and answers.  Thanks in advance!!

Regards,
Andy

