From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 02/17] DSPBRIDGE: Implemented Trampoline support for
 	dynamic loader
Date: Tue, 15 Dec 2009 16:14:57 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042D396AD9@dlee03.ent.ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
	 <1260857998-19349-3-git-send-email-omar.ramirez@ti.com>
 <94a0d4530912151024v43b5941apdc3afeb00e18145c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35541 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933958AbZLOWPG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 17:15:06 -0500
In-Reply-To: <94a0d4530912151024v43b5941apdc3afeb00e18145c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Tuesday, December 15, 2009 12:25 PM
>
>On Tue, Dec 15, 2009 at 8:19 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>
>> Implemented on dynamic loader automatic generation of
>> trampolines when near calls are made to outside of signed
>> 21-bit offset available in the C64X+ DSP.
>
>The commit message is not clear: Why do we want this? What problem is
>fixed? Is old behavior changed, or is it an independent feature?
>

New commit message:

"Trampolines" utilize memory space containing a local jump
table to hit external locations. Instead of the "near"
function call directly calling the external location it
"calls" a trampoline entry.

A "near" function call requires the target to be within a
signed, 21-bit offset from the current PC so all calls have
to be within 4MB of the current execution point.

The trampoline entry (location in memory) contains an
unconditional long branch to the external address to be
called. When the called function returns, the PC is returned
to the original calling location since that is where the
link register points, as the trampoline utilizes a branch
instruction.

Utilizing this method removes the 4MB location restriction
as well since the long branch can be done within all of DSP
addressable space.

This doesn't require any change on the dsp side, it is an
enhancement for newer DSP side binaries.

- omar
