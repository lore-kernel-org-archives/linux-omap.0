From: Joe Perches <joe@perches.com>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 00:04:04 -0800
Message-ID: <1511856244.19952.14.camel@perches.com>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
         <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
         <1511809633.32426.70.camel@perches.com>
         <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
         <1511833514.32426.86.camel@perches.com>
         <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-11-28 at 08:41 +0100, SF Markus Elfring wrote:
> > > It seems that I got no responses so far for clarification requests
> > > according to the documentation in a direction I hoped for.
> > 
> > That's because you are pretty unresponsive to direction.
> 
> From which places did you get this impression?

How many times have I told you to include the reason for
your patches in
your proposed commit message?  Too often.

For instance, specific to this patch:

Many people do not know that a generic kmalloc does a
dump_stack() on OOM.  That information should be part
of the commit message.

Also removing the printk code reduces overall code size.
The actual size reduction should be described in the
commit message too.
