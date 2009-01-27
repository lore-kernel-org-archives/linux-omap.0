From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: No audio support for BeagleBoard in Latest GIT tree?
Date: Tue, 27 Jan 2009 12:51:57 +0200
Message-ID: <200901271251.57923.peter.ujfalusi@nokia.com>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <200901271138.03901.peter.ujfalusi@nokia.com> <320898.80694.qm@web81105.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32607 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZA0KwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 05:52:20 -0500
In-Reply-To: <320898.80694.qm@web81105.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ndno72-omap@yahoo.com" <ndno72-omap@yahoo.com>
Cc: beagleboard@googlegroups.com, "linux-omap@vger.kernel.orgList" <linux-omap@vger.kernel.org>


On Tuesday 27 January 2009 12:35:40 ext ndno72-omap@yahoo.com wrote:
> > You need to take this patch sent by Steve Sakoman:
> > http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3D=
commit;h=3D
> >80c509fdd74f3b158267374cc55156965c8bf930 This has been sent to l-o a=
lso,
> > so you can take the patch from this mailing list...
>
> Thanks!  So where is the official OMAP3 GIT tree located?  The one yo=
u
> mentioned above has Steve's patch but the one (Steve's own link) ment=
ioned
> on the wiki page doesn't.  There are 2 or 3 OMAP3 GIT sites out there=
 and I
> don't know which one is the "official" working one.  I just noticed t=
he one
> sponsored by Montavista  is now obsolete.

The link above points to sound-2.6 (Takashi Iwai's tree), the official=20
ALSA/Sound tree.

AFAIK the official OMAP tree is:=20
http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dsummary

>
> Regards,
> Andy

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
