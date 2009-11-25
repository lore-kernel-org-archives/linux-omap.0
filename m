From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
Date: Wed, 25 Nov 2009 15:56:50 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426F26837@dlee03.ent.ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <4B0DA394.2030705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935101AbZKYV4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 16:56:50 -0500
In-Reply-To: <4B0DA394.2030705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From: Menon, Nishanth
>Subject: Re: [PATCH 2/9] DSPBRIDGE: trivial checkpatch fixes
>
>Ramirez Luna, Omar had written, on 11/23/2009 06:50 PM, the following:
>> Quick fixes like:
>General comment: please do white space changes as a separate patch. this
>massive patch is pretty difficult to review otherwise.. might have been
>as simple as doing scripts/Lindent on all files and refixing with
>scripts/checkpatch.pl ..
>
>[...]
>

Will do that... I guess you won't like to read patch 3 ;) as I mixed spacing changes with do while for multiline macros (will split them and resend)

- omar
