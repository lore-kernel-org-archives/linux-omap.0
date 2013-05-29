From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v1 1/3] PM / AVS: SmartReflex: disable errgen before vpbound disable
Date: Wed, 29 May 2013 07:01:57 -0700
Message-ID: <87fvx5anqi.fsf@linaro.org>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
	<1369652846-14412-2-git-send-email-andrii.tseglytskyi@ti.com>
	<87sj17aqq2.fsf@linaro.org> <51A5D148.8050203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A5D148.8050203@ti.com> (Andrii Tseglytskyi's message of "Wed,
	29 May 2013 12:58:32 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

[...]

>>> Signed-off-by: Vincent Bour <v-bour@ti.com>
>>> Signed-off-by: Leonardo Affortunati <l-affortunati@ti.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
>>  From Documentation/SubbmittingPatches:
>>
>>     "If a person was not directly involved in the preparation or handling
>>     of a patch but wishes to signify and record their approval of it then
>>     they can arrange to have an Acked-by: line added to the patch's
>>     changelog."
>>
>> Are all of the tags above co-authors or on the delivery path?  I suspect
>> an Acked-by or Reviewed-by is more appropriate here.

[...]

> This patch was developed by Nishanth, he is the author of the code.
> Patch is the result of 2-week debug session. Vincent, Leonardo and
> Nishanth were involved to that debug session.
> My contribution to this patch - is sending it to upstream, no more
> than this.
> Could you please suggest - who should remain in Signed-offs ?

Nishanth as the author, and you since you're on the delivery path.

If Vincent & Leonardo should be considered as co-authors, then their
signoffs are fine, otherwise they should be reviewed-by or acked-by.

Kevin
