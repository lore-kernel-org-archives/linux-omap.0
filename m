From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCHv2 18/18] DSPBRIDGE: Compilation fixes 2.6.31
Date: Fri, 18 Dec 2009 15:50:03 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042D7EAE61@dlee03.ent.ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-12-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-13-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-14-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-15-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-16-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-17-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-18-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
 <94a0d4530912180948r527cdb15w7ec241b2f6ad1fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932804AbZLRVuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 16:50:20 -0500
In-Reply-To: <94a0d4530912180948r527cdb15w7ec241b2f6ad1fbb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Hi,

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Friday, December 18, 2009 11:49 AM
>To: Ramirez Luna, Omar
>Cc: linux-omap; Hiroshi Doyu; Ameya Palande; Felipe Contreras; Guzman =
Lugo, Fernando; Ramos Falcon,
>Ernesto
>Subject: Re: [PATCHv2 18/18] DSPBRIDGE: Compilation fixes 2.6.31
>
>On Thu, Dec 17, 2009 at 4:16 AM, Omar Ramirez Luna <omar.ramirez@ti.co=
m> wrote:
>> Compilation fixes 2.6.31
>>
>> =A0 =A0 =A0 =A0board-sdp3430.h not found
>> =A0 =A0 =A0 =A0clk_handle undefined because of DVFS flag
>
>In fact, these are not specific to 2.6.31. The changes are good to
>have even on 2.6.28; they would get rid of warnings on certain
>configurations.
>
>So I'm sending a proposal that's a bit different: first I clean the PM
>idefs, then I remove unused headers. The end result is almost the
>same: the code compiles on 2.6.31 :)
>

Had a quick look at them, I agree patch 18 (DSPBRIDGE: Compilation fixe=
s 2.6.31) can be replaced.

- omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
