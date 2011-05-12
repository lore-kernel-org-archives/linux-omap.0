From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Thu, 12 May 2011 12:37:28 -0500
Message-ID: <BANLkTimmFdbLfS9wxXkKXAVwY9BFmkDs7Q@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
 <BANLkTimem2qc8_8pHOHMiW_hAeUdtg3PBw@mail.gmail.com> <87fwokcknl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39880 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758008Ab1ELRhu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 13:37:50 -0400
Received: by wyb34 with SMTP id 34so1743120wyb.15
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 10:37:48 -0700 (PDT)
In-Reply-To: <87fwokcknl.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 12, 2011 at 04:50, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Wed, May 11, 2011 at 04:12, Shweta Gulati <shweta.gulati@ti.com> =
wrote:
>>> To set sr ntarget values =A0for all volt_domain,
>>> volt_table is retrieved by doing a look_up of 'vdd_name'
>>> field from omap_hwmod but voltage domain pointer does not
>>> belong to omap_hwmod and is not used anywhere else.
>>> As a part of voltage layer and SR Layer clean up volt
>>> pointer is removed from omap_hwmod and added in dev
>>> attributes of SR.
>>>
>>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>>
>>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> ---
>>> V3:
>>> =A0 Changed the Subject and Rephrased Commit log as reviewed
>>> =A0 by Nishanth Menon.
>>> =A0V2:
>>> =A0 Rebased on latest 'pm-wip/voltdm_a' branch.
>> thanks.. actually it applies on voltdm_c branch as well :)
>
> Can this be taken as an Ack? =A0if so, Shweta please add an Acked-by =
from
> Nishanth in your updated patch. =A0Thanks.
yep - will merge the next rev and do a dry run as well..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
