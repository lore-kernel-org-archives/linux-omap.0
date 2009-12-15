From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: dspbridge sync proposal for 0.1
Date: Tue, 15 Dec 2009 13:45:55 +0200
Message-ID: <94a0d4530912150345p2009dbddra805fd298ffc9e92@mail.gmail.com>
References: <20091205133900.GA17280@annwn.felipec.org>
	 <94a0d4530912140803t4f910549ga04b02a14dabe715@mail.gmail.com>
	 <27F9C60D11D683428E133F85D2BB4A53042D3963E0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55623 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZLOLp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 06:45:57 -0500
Received: by iwn1 with SMTP id 1so875760iwn.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 03:45:56 -0800 (PST)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042D3963E0@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Tue, Dec 15, 2009 at 7:53 AM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> After the analysis of both branches (current dspbridge and dspbridge-=
0.1) and the need to resend the patches that haven't been reviewed. It =
was decided that the unsent patches would be reverted and sent to the l=
ist for review, given the need to have a baseline that works for most o=
f the OMAP 3 platforms, I took Felipe's patch order proposal (as it is =
working for N900) and recreated the future dspbridge branch.
>
> This can be found at:
> http://dev.omapzoom.org/?p=3Dtidspbridge/kernel-dspbridge.git;a=3Dsum=
mary =C2=A0dspbridge-baseline-v2

There's something wrong with that repository; I can't  retrieve it in a=
ny way:

% git remote add omar git://dev.omapzoom.org/pub/scm/tidspbrid
% git fetch omar
fatal: The remote end hung up unexpectedly
fatal: protocol error: bad pack header

% git clone git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge=
=2Egit
--reference=3D~src/linux tmp-omar
Initialized empty Git repository in tmp-omar/.git/
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

% git clone git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge=
=2Egit
tmp-omar
Initialized empty Git repository in tmp-omar/.git/
remote: Counting objects: 1430544, done.
remote: Compressing objects: 100% (238646/238646), done.
fatal: The remote end hung up unexpectedly3.75 MiB | 37 KiB/s
fatal: early EOF
fatal: index-pack failed

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
