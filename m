From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 18:50:16 +0100
Message-ID: <20171128175016.GA3501@lenoch>
References: <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
 <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
 <20171128114130.GA1615@lenoch>
 <bdf052ef-4f32-af1e-4b1b-6fb75e5e0af9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bdf052ef-4f32-af1e-4b1b-6fb75e5e0af9@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 01:13:51PM +0100, SF Markus Elfring wrote:
> Additional improvement possibilities can be taken into account
> after corresponding software development discussions, can't they?

Sure, but that is in contrary to all you replies. I guess you are
familiar with Documentation/process/submitting-patches.rst chapter 8.
No matter that patch was generated or suggested by a tool, you sent
it and normal review procedure follows. And here you ignored _all_
suggestions and concentrate solely on improving Coccinelle scripts.

On kernel related lists suggestions to patch itself are discussed.
Whenever you take them into account while developing Coccinelle
is up to you (on the Cocci list).

Best regards,
	ladis
