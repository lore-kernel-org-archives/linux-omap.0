From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 18:27:08 +0100
Message-ID: <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>> Omit an extra message for a memory allocation failure in these functions.
…
> nak, unlike many others, these message give extra info on which
> allocation failed, that can be useful.

Can a default allocation failure report provide the information
which you might expect so far?

Regards,
Markus
