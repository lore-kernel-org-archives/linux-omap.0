From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else
 constructions
Date: Tue, 10 May 2011 15:08:05 +0300
Message-ID: <1305029285.2045.38.camel@deskari>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
	 <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niels de Vos <ndevos@redhat.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-05-10 at 11:42 +0200, Geert Uytterhoeven wrote:

> What about using the standard pr_debug()/dev_dbg() instead?
> With dynamic debug, it can be enabled at run time.
> As a bonus, you get printf()-style format checking if debugging is disabled.

Yes, dev_dbg & co. would be better.

However, one thing I dislike about them is the extra stuff they print.
For example, for omapfb and omapdss dev_dbg will print:

omapfb omapfb: foo
omapdss_dss omapdss_dss: foo

I originally added the debug macros to omapdss to be able to
automatically print the DSS module name, as at that point there was only
one big omapdss device. And I guess I just followed with similar macro
in omapfb also. But I believe both omapdss and omapfb should be changed
to dev_* prints sometime soon.

 Tomi
