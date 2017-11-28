From: Joe Perches <joe@perches.com>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 06:36:50 -0800
Message-ID: <1511879810.19952.16.camel@perches.com>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
         <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
         <1511809633.32426.70.camel@perches.com>
         <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
         <1511833514.32426.86.camel@perches.com>
         <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
         <1511856244.19952.14.camel@perches.com>
         <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
         <alpine.DEB.2.20.1711281026410.3443@hadrien>
         <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
         <20171128102327.GA30267@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171128102327.GA30267@lenoch>
Sender: kernel-janitors-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-11-28 at 11:23 +0100, Ladislav Michl wrote:
> I do not follow. This is OMAP framebuffer driver, so in this case, there
> is zero variation. Could you, please, review following patch and verify
> is it satisfies your automated static code analysis test?

Obviously a better patch.

I suggest submitting it properly and letting the 0-day
build bot have a go at it.

cheers, Joe

