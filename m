From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Thu, 12 May 2011 11:50:38 +0200
Message-ID: <87fwokcknl.fsf@ti.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
	<BANLkTimem2qc8_8pHOHMiW_hAeUdtg3PBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47582 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756626Ab1ELJup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 05:50:45 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1515516fxm.33
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 02:50:44 -0700 (PDT)
In-Reply-To: <BANLkTimem2qc8_8pHOHMiW_hAeUdtg3PBw@mail.gmail.com> (Nishanth
	Menon's message of "Wed, 11 May 2011 06:15:22 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, May 11, 2011 at 04:12, Shweta Gulati <shweta.gulati@ti.com> w=
rote:
>> To set sr ntarget values =C2=A0for all volt_domain,
>> volt_table is retrieved by doing a look_up of 'vdd_name'
>> field from omap_hwmod but voltage domain pointer does not
>> belong to omap_hwmod and is not used anywhere else.
>> As a part of voltage layer and SR Layer clean up volt
>> pointer is removed from omap_hwmod and added in dev
>> attributes of SR.
>>
>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> ---
>> V3:
>> =C2=A0 Changed the Subject and Rephrased Commit log as reviewed
>> =C2=A0 by Nishanth Menon.
>> =C2=A0V2:
>> =C2=A0 Rebased on latest 'pm-wip/voltdm_a' branch.
> thanks.. actually it applies on voltdm_c branch as well :)=20

Can this be taken as an Ack?  if so, Shweta please add an Acked-by from
Nishanth in your updated patch.  Thanks.

> might be
> good if kevin where to roll it up

Yes, I'll pick this one up (after Todd's comments are addressed.)

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
