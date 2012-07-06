From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri, 06 Jul 2012 11:22:55 +0200
Message-ID: <4FF6AE6F.4000808@ti.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com> <CAMQu2gyZQGGVQQtidGwOCux-0hX=FmPVP+9Sej_VRrQMurd=mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33465 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138Ab2GFJWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 05:22:39 -0400
Received: by obbtb18 with SMTP id tb18so9361366obb.21
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 02:22:38 -0700 (PDT)
In-Reply-To: <CAMQu2gyZQGGVQQtidGwOCux-0hX=FmPVP+9Sej_VRrQMurd=mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/06/2012 11:02 AM, Shilimkar, Santosh wrote:
> On Fri, Jul 6, 2012 at 2:19 PM, Peter Ujfalusi <peter.ujfalusi@ti.com=
> wrote:
>> The sys_nirq2 is used for twl6040, make sure the pin is configured
>> correctly.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
> Should remove the boot-loader pin-muxing dependency.
> Was this the reason, Audio had some issues on OMAP4430
> SDP as reported by Russell ?

The boot loader never configured the sys_nirq2, I have sent a patch for=
 u-boot
to do this, but it is said that the kernel should take care of this.

We did not had jack detection working with upstream u-boot, kernel (I h=
ave
patched u-boot so I have not seen this issue).
Now if the board is booted without HS connected, upon connecting the HS=
 we
will recognize it and it should be all fine.
So yes this was the reason why Russell had issues with audio.

--=20
P=E9ter


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
