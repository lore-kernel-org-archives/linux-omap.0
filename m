From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Fri, 13 Apr 2012 10:15:30 -0400
Message-ID: <1334326531.4033.12.camel@deneb.redhat.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
	 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aneesh V <aneesh@ti.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mgreer@animalcreek.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2012-04-11 at 20:44 -0600, Paul Walmsley wrote:
> This is useful not only for OMAP4 and AM3517/3505, but also will probably 
> be useful for the C6x chips that Mark Salter is working on.

I have been keeping an occasional eye on these patches but I don't see
any usefulness for the currently supported C6X chips. The current set
of supported chips use a completely different DDR controller. There is
an EMIF controller on some which provides a parallel bus for connecting
to external devices (NOR flash, etc) but it looks completely different
from the OMAP EMIF. I think the TI DaVinci chips have EMIF (and other IO
blocks) similar to C6X which could use common drivers.

--Mark
