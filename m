From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] OMAP: Add keypad driver
Date: Thu, 7 Jan 2016 22:38:49 -0800
Message-ID: <20160108063849.GA22781@dtor-ws>
References: <20160107093751.GD27186@mwanda>
 <20160107201316.GF12600@atomide.com>
 <20160107232228.GA20533@dtor-ws>
 <2618759.QX3pTDJjW3@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2618759.QX3pTDJjW3@acer>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Komal Shah <komal_shah802003@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 08, 2016 at 02:41:00AM +0100, Janusz Krzysztofik wrote:
> On Thu, 7 Jan 2016 15:22:28 Dmitry Torokhov wrote:
> > On Thu, Jan 07, 2016 at 12:13:17PM -0800, Tony Lindgren wrote:
> > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [160107 10:54]:
> > > > On Thu, Jan 7, 2016 at 1:37 AM, Dan Carpenter 
> <dan.carpenter@oracle.com> wrote:
> > > > ...
> > > > >    157                          key = 
> keycodes[MATRIX_SCAN_CODE(row, col, row_shift)];
> > > > >    158                          if (key < 0) {
> > > > >                                     ^^^^^^^
> > > > > Never true.  Not sure what was intended.
> > > > 
> > > > It looks like this check was broken by
> > > > da1f026b532ce944d74461497dc6d8c16456466e (Keyboard: omap-keypad: 
> use
> > > > matrix_keypad.h). Previously the driver would expect a list of 
> known
> > > > keys and would scan it and return -1 if key was not found. Now we 
> have
> > > > 2 options:
> > > > 
> > > > 1. Simply remove the check
> > > > 2. Change the condition to "if (key == KEY_RESERVED)"
> > > > 
> > > > I do not really have preference. Tony?
> > > 
> > > Sounds like the check is not needed if it has not been used for
> > > past five years, so my preference is option #1 then.
> > 
> > OK, how about the below then?
> > 
> > --
> > Dmitry
> > 
> > 
> > Input: omap-keypad - remove dead check
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Commit da1f026b532ce944d74461497dc6d8c16456466e ("Keyboard:
> > omap-keypad: use matrix_keypad.h") switched the driver to use matrix
> > keypad infrastructure, which made array of keycodes to be unsigned
> > short, and caused the test for negativity never trigger. This leads
> > to the following> 
> > static checker warning:
> >         drivers/input/keyboard/omap-keypad.c:158 omap_kp_tasklet()
> >         warn: 'keycodes[]' is never negative.
> > 
> > Given that we did not care about this check for a few years already
> > let's simply remove it.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> >  drivers/input/keyboard/omap-keypad.c |    8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/omap-keypad.c
> > b/drivers/input/keyboard/omap-keypad.c index 75ad666..e0d72c8 100644
> > --- a/drivers/input/keyboard/omap-keypad.c
> > +++ b/drivers/input/keyboard/omap-keypad.c
> > @@ -155,14 +155,6 @@ static void omap_kp_tasklet(unsigned long data) 
> >                                "pressed" : "released");  
> >  #else  
> >                         key = keycodes[MATRIX_SCAN_CODE(row, col, 
> row_shift)]; 
> > -                       if (key < 0) {
> > -                               printk(KERN_WARNING
> > -                                     "omap-keypad: Spurious key event 
> %d-%d\n",
> > -                                      col, row);
> > -                               /* We scan again after a couple of 
> seconds */
> > -                               spurious = 1;
> 
> Hi,
> 
> That code was written before I played with it so I'm not really sure 
> about its purpose, but it looks to me like something intended as a 
> debouncer.
> 
> Since that was the only place where the spurious variable could be 
> modified, I think we should also remove the now unreachable code that 
> manipulates delay based on spurious value several lines below, as well 
> as declaration and initialization of spurious at the beginning of 
> omap_kp_tasklet().

Yeah, now that I look at it this driver needs some love. The probing is
racy, remove is incomplete, etc.

Do any of you guys have hardware that uses it?

Thanks.

-- 
Dmitry
