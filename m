From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 03/18] MAINTAINERS: OMAP POWERDOMAIN, update patterns
Date: Mon, 22 Jul 2013 05:03:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307220501390.4804@utopia.booyaka.com>
References: <cover.1374451988.git.joe@perches.com> <8c1406e78f8536ff46ad9000b5634487243d5854.1374451988.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c1406e78f8536ff46ad9000b5634487243d5854.1374451988.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, cesarb@cesarb.net
List-Id: linux-omap@vger.kernel.org

On Sun, 21 Jul 2013, Joe Perches wrote:

> commit 498153995b9 ("ARM: OMAP2+: powerdomain/PRM: move the
> low-level powerdomain") renamed the files, update the patterns.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> cc: Paul Walmsley <paul@pwsan.com>
> cc: Rajendra Nayak <rnayak@ti.com>
> cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

I don't object to the content of this patch, but Cesar 
Eduardo Barros posted a patch for this already (and cc'ed you) back 
in March:

http://lkml.indiana.edu/hypermail/linux/kernel/1303.0/00904.html

The regex used in his pattern is also more accurate.  Please take his 
patch instead, or credit him in your patch and use the cm*.[ch]/prm*.[ch] 
notation from his patch.


- Paul
