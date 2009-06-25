From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] TI dspbridge Omapzoom tree
Date: Thu, 25 Jun 2009 12:46:53 +0300
Message-ID: <94a0d4530906250246j3bbc7806m484cdd4c56506664@mail.gmail.com>
References: <AcnkmTizIuzfPY/xQ2W9ciK2lcvleQ==>
	 <27F9C60D11D683428E133F85D2BB4A53040F3FC45F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:52483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZFYJqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 05:46:51 -0400
Received: by fg-out-1718.google.com with SMTP id e21so234436fga.17
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 02:46:53 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53040F3FC45F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 4, 2009 at 1:18 AM, Ramirez Luna, Omar<omar.ramirez@ti.com>=
 wrote:
> Hi,
>
> The new dspbridge omapzoom tree has been set in place, you can clone =
it from:
>
> =C2=A0 =C2=A0git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbri=
dge.git
> or
> =C2=A0 =C2=A0http://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbr=
idge.git
>
> In this tree you will find the latest set of TI DSP BRIDGE patches, w=
hich are
> based on linux-omap kernel tree. The branch layout is as follows:
>
> =C2=A0master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t=
racking L-O master
> =C2=A0bridge-pm-2.6.28 =C2=A0 =C2=A0 =C2=A0branched from omap-2.6.28,=
 pulled linux-omap-pm
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pm-2.6.28 on top, + bridge patches
> =C2=A0bridge-pm-2.6.29 =C2=A0 =C2=A0 =C2=A0branched from L-O pm branc=
h + bridge patches
>
> Special thanks to Hiroshi Doyu and Ameya Palande, and to all who have
> contributed with comments and patches.
>
> For the new dspbridge tree, I took the logical set of patches which w=
as ported
> long time back[1] along with the new stuff, reworked what we had to m=
igrate to
> this baseline and already sent the patches to the list, those patches=
 can be
> found in the new tree.

Where is this documented?
I don't see this on the list of repos in http://git.omapzoom.org/

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
