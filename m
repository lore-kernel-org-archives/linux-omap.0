From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: dspbridge sync proposal for 0.1
Date: Mon, 14 Dec 2009 23:53:19 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042D3963E0@dlee03.ent.ti.com>
References: <20091205133900.GA17280@annwn.felipec.org>
 <94a0d4530912140803t4f910549ga04b02a14dabe715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43434 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbZLOFx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 00:53:26 -0500
In-Reply-To: <94a0d4530912140803t4f910549ga04b02a14dabe715@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Artem Bityutskiy <artem.bityutskiy@nokia.com>, "Shah, Bhavin" <bshah@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@nokia.com>

Hi,

>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Monday, December 14, 2009 10:04 AM
>
>On Sat, Dec 5, 2009 at 3:39 PM, Felipe Contreras
><felipe.contreras@nokia.com> wrote:
>> There is a proposal to get the dspbridge branch into a decent state for
>> the 0.1 release, so I've been trying to synchronize the internal maemo
>> branch with the upstream one.
>
>After a few private discussions with Omar here's v2 which is
>essentially the same except many patches are taking from TI. There's
>not much difference in the actual content, the difference it's mostly
>in the commit messages:
>
>All the branches are in:
>http://gitorious.org/~felipec/linux-omap/felipec
>
>The branch for the current proposal is 'dspbridge-0.1-v2'.
>

As a follow up...

After the analysis of both branches (current dspbridge and dspbridge-0.1) and the need to resend the patches that haven't been reviewed. It was decided that the unsent patches would be reverted and sent to the list for review, given the need to have a baseline that works for most of the OMAP 3 platforms, I took Felipe's patch order proposal (as it is working for N900) and recreated the future dspbridge branch.

This can be found at:
http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=summary  dspbridge-baseline-v2

Differences:

- DSPBRIDGE: enable smart/autoidle for mailbox sysconfig
Patch dropped until final version is discussed

- DSPBRIDGE: Pass filp->private to all the ioctl wrappers
Patch dropped until resource cleanup patches are discussed, this to keep the entire series of resource cleanup changes out.

- DSPBRIDGE: Increased DMM size to 256MB
Will be pushed on top of all patches as it seems it is breaking N900, this until failure is root caused.

- DSPBRIDGE: Remove PID usage and replace with TGID
Pushed as it was sent to LO mailing list.


Next step will be to send the unreviewed patches and continue until no patches are missing. For now and until -baseline-v2 is synchronized, further development will continue on dspbridge-next.

Regards,

Omar
