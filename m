From: "Dechesne, Nicolas" <n-dechesne@ti.com>
Subject: RE: dspbridge sync proposal for 0.1
Date: Tue, 15 Dec 2009 13:58:40 +0100
Message-ID: <E8606C3FD412994585953171ED63A93401519EB627@dnce01.ent.ti.com>
References: <20091205133900.GA17280@annwn.felipec.org>
 <94a0d4530912140803t4f910549ga04b02a14dabe715@mail.gmail.com>
 <27F9C60D11D683428E133F85D2BB4A53042D3963E0@dlee03.ent.ti.com>
 <94a0d4530912150345p2009dbddra805fd298ffc9e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40297 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbZLOM76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 07:59:58 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <94a0d4530912150345p2009dbddra805fd298ffc9e92@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Deacon, Keith" <kdeacon@ti.com>


>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
> Contreras
> Sent: Tuesday, December 15, 2009 12:46 PM
> To: Ramirez Luna, Omar
> Cc: linux-omap; Hiroshi Doyu; Ameya Palande; Artem
> Bityutskiy; Shah, Bhavin; Tony Lindgren; Felipe Contreras
> Subject: Re: dspbridge sync proposal for 0.1
>
> On Tue, Dec 15, 2009 at 7:53 AM, Ramirez Luna, Omar
> <omar.ramirez@ti.com> wrote:
> > After the analysis of both branches (current dspbridge and
> dspbridge-0.1) and the need to resend the patches that
> haven't been reviewed. It was decided that the unsent patches
> would be reverted and sent to the list for review, given the
> need to have a baseline that works for most of the OMAP 3
> platforms, I took Felipe's patch order proposal (as it is
> working for N900) and recreated the future dspbridge branch.
> >
> > This can be found at:
> >
> http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=
> summary
> > dspbridge-baseline-v2
>
> There's something wrong with that repository; I can't
> retrieve it in any way:

It's somehow a known issue. We are facing issues with dev.omapzoom.org and git.omapzoom.org servers and we are trying to resolve them.

>
> % git remote add omar git://dev.omapzoom.org/pub/scm/tidspbrid
> % git fetch omar
> fatal: The remote end hung up unexpectedly
> fatal: protocol error: bad pack header
>
> % git clone
> git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git
> --reference=~src/linux tmp-omar
> Initialized empty Git repository in tmp-omar/.git/
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
>
> % git clone
> git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git
> tmp-omar
> Initialized empty Git repository in tmp-omar/.git/
> remote: Counting objects: 1430544, done.
> remote: Compressing objects: 100% (238646/238646), done.
> fatal: The remote end hung up unexpectedly3.75 MiB | 37 KiB/s
> fatal: early EOF
> fatal: index-pack failed
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
>
