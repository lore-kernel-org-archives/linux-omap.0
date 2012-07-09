From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: board-4430sdp: MUX configuration for
 sys_nirq2
Date: Mon, 09 Jul 2012 11:38:55 +0200
Message-ID: <4FFAA6AF.2010004@ti.com>
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com> <1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com> <874nplc6va.fsf@ti.com> <CAMQu2gx4927Ze9tRUFq9QPubGFWfK9bHqZhVCb7c39O=WeWA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33494 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751764Ab2GIJil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 05:38:41 -0400
Received: by obbuo13 with SMTP id uo13so23058784obb.5
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 02:38:40 -0700 (PDT)
In-Reply-To: <CAMQu2gx4927Ze9tRUFq9QPubGFWfK9bHqZhVCb7c39O=WeWA3Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/06/2012 04:33 PM, Shilimkar, Santosh wrote:
>> Since this is TWL6030 specific, it should rather be done in TWL code
>> like I did for sys_nirq1:
>>
>>    http://marc.info/?l=3Dlinux-omap&m=3D134090312118873&w=3D2
>>
>> That would avoid having to do this in both board files.
>>
> Though the pin is TWL specific, it need not be same on
> different board with different SOCs. Especially when you need to
> set MUX mode etc. So doing from board file is still better
> since TWL6030/40 can be connected to non OMAP4 devices
> where the muxing can be different.
>=20
> With current know boards with TWL6030/40, this is not
> a strong requirement though.

There can be board which has twl6030 but does not have twl6040.
The twl6040 is the recommended audio solution for OMAP4+ systems but it=
 can be
replaced by other codec on some boards.
This is the reason I have put the mux configuration into the board file=
s for
sys_nirq2 (which is in these cases are used to handle the interrupt fro=
m twl6040).

--=20
P=E9ter


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
