From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation
 in three functions
Date: Tue, 28 Nov 2017 10:28:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711281026410.3443@hadrien>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-798230509-1511861328=:3443"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--8323329-798230509-1511861328=:3443
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 28 Nov 2017, SF Markus Elfring wrote:

> > How many times have I told you to include the reason for
> > your patches in your proposed commit message?
>
> It might be useful to look again.
>
>
> > Too often.
>
> I answered this feedback to some degree.
>
>
> > Many people do not know that a generic kmalloc does a
> > dump_stack() on OOM.
>
> This is another interesting information, isn't it?
>
> It is expected that the function “devm_kzalloc” has got a similar property.


You don't have to expect this.  Go look at the definition of devm_kzalloc
and see whether it has the property or not.

> For which hardware and software combinations would you like to see
> facts there?

This is not for Joe to decide, it's for the person who receives the patch
to decide.  You could start with the ones for which the code actually
compiles, using the standard make file and no special options, and a
recent version of gcc.

julia
--8323329-798230509-1511861328=:3443
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--8323329-798230509-1511861328=:3443--
