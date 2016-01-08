From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Add keypad driver
Date: Thu, 7 Jan 2016 16:13:45 -0800
Message-ID: <20160108001344.GR12777@atomide.com>
References: <20160107093751.GD27186@mwanda>
 <CAKdAkRSic46XAhuXO6fijBTWMaRJPqRNPx6MwTv=Pgoo6JL=hQ@mail.gmail.com>
 <20160107201316.GF12600@atomide.com>
 <20160107232228.GA20533@dtor-ws>
 <EA34CFB38EA5944FBA4415964A4F7AD80CEAECBF@DEMUMBX010.nsn-intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EA34CFB38EA5944FBA4415964A4F7AD80CEAECBF@DEMUMBX010.nsn-intra.net>
Sender: linux-input-owner@vger.kernel.org
To: "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
Cc: EXT Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Komal Shah <komal_shah802003@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Koskinen, Aaro (Nokia - FI/Espoo) <aaro.koskinen@nokia.com> [160107 16:08]:
> Hi,
> 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > Commit da1f026b532ce944d74461497dc6d8c16456466e ("Keyboard: omap-keypad:
> > use matrix_keypad.h") switched the driver to use matrix keypad
> > infrastructure, which made array of keycodes to be unsigned short, and
> > caused the test for negativity never trigger. This leads to the following
> > static checker warning:
> >
> >        drivers/input/keyboard/omap-keypad.c:158 omap_kp_tasklet()
> >        warn: 'keycodes[]' is never negative.
> >
> > Given that we did not care about this check for a few years already let's
> > simply remove it.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Heh sorry I mis-corrected your email in my reply, old habit you know :)

Tony
