From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2] ADP1653 board code for Nokia RX-51
Date: Sun, 8 Sep 2013 02:02:52 +0300
Message-ID: <20130907230252.GA10700@blackmetal.musicnaut.iki.fi>
References: <201302171616.50152@pali>
 <20130217190303.GC2317@blackmetal.musicnaut.iki.fi>
 <201303062112.06417@pali>
 <201309062234.05878@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309062234.05878@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 06, 2013 at 10:34:05PM +0200, Pali Roh=E1r wrote:
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-rx51-camera.c
[...]
> Ping, can you review this patch v2?

I don't think Tony will accept any new board stuff for RX-51/N900.
See for example: http://marc.info/?l=3Dlinux-kernel&m=3D137629626213187=
&w=3D2

There should be initial Nokia N900 DTS file in 3.12-rc1, and we should
continue converting this board fully to DT.

A.
