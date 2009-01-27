From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: No audio support for BeagleBoard in Latest GIT tree?
Date: Tue, 27 Jan 2009 11:38:03 +0200
Message-ID: <200901271138.03901.peter.ujfalusi@nokia.com>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <bd7b27490901250616q2363c5b4wf422d32831bd3638@mail.gmail.com> <258288.30602.qm@web81108.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25157 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZA0JiL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 04:38:11 -0500
In-Reply-To: <258288.30602.qm@web81108.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ndno72-omap@yahoo.com" <ndno72-omap@yahoo.com>
Cc: beagleboard@googlegroups.com, "linux-omap@vger.kernel.orgList" <linux-omap@vger.kernel.org>

Hello,

On Tuesday 27 January 2009 11:18:16 ext ndno72-omap@yahoo.com wrote:
> Hi everyone,
>
> Last week, I downloaded the 2.6.29-rc2
> (http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.gi=
t;a=3Dtag;
>h=3Dd31ce8060b0e875179ba5ca1d40475dc2a082cc7) and compiled it for the
> BeagleBoard.  Everything seems to run fine (I disabled video support
> because I don't use it).  However, there doesn't seem to be audio (tw=
l4030
> audio) support for the BeagleBoard; the default configuration
> (omap3_beagle_defconfig) doesn't enable audio and when I tried to ena=
ble
> ALSA, there's no option for the twl4030 driver.  Is audio not yet sup=
ported
> in the last GIT tree?  What the latest tag/tree (v2.6.28-omap1???) I =
should
> use that has audio support for the BeagleBoard.

You need to take this patch sent by Steve Sakoman:
http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dcom=
mit;h=3D80c509fdd74f3b158267374cc55156965c8bf930
This has been sent to l-o also, so you can take the patch from this mai=
ling=20
list...

>
>
> Regards,
> Andy
>

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
