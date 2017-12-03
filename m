From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Sun, 3 Dec 2017 19:20:47 +0100
Message-ID: <21554e23-e714-3f6f-cd70-4c277823bab3@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1511856244.19952.14.camel@perches.com>
Content-Language: en-GB
Sender: linux-doc-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Cc: "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

> How many times have I told you to include the reason for your patches
> in your proposed commit message?

Will it be useful to look again at the involved circumstances?


> Too often.

Did I answer any concerns partly?


> Many people do not know that a generic kmalloc does a dump_stack() on OOM.

Do you see a need to represent such information better?

Is it expected that the function “devm_kzalloc” has got a similar property?


> That information should be part of the commit message.

How do you think about to share it also from any reference documentation
in a clearer way?

Do we stumble on a target conflict in this case?

I am generally trying to improve the software situation to some degree.
I prefer then to work with safe information sources.
Unfortunately, I might have not reached a desired confidence level here
for a more detailed commit message. I assume that software development
efforts could increase in significant ways if something should be improved
further in a direction I hope. But this could mean that time frames will
grow for corresponding clarifications.

* Does such a situation block progress on the deletion of other remaining
  questionable error messages?

* Would you like to increase the software development attention anyhow?



By the way:
It seems that my update suggestion for the directory “omapfb/dss”
could be superseded by the patch “omapfb: dss: Do not duplicate features data”
from Ladislav Michl.
https://patchwork.kernel.org/patch/10082027/
https://lkml.kernel.org/r/<20171129123308.GA26578@lenoch>

Regards,
Markus
