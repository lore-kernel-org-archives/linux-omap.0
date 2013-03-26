From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Tue, 26 Mar 2013 11:40:58 -0700
Message-ID: <20130326184058.GA4194@kroah.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com>
 <20130107210551.GL14149@atomide.com>
 <201301072135.05166.arnd@arndb.de>
 <89A7A8FD-935E-4225-8C7B-EA1DBA0C2780@antoniou-consulting.com>
 <20130108100042.GD21994@gmail.com>
 <21E7B891-269B-422D-9038-381FAA15B59B@antoniou-consulting.com>
 <20130326161610.804983E2499@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130326161610.804983E2499@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 26, 2013 at 04:16:10PM +0000, Grant Likely wrote:
> On Tue, 8 Jan 2013 12:10:20 +0200, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
> > Hi Lee,
> > 
> > On Jan 8, 2013, at 12:00 PM, Lee Jones wrote:
> > 
> > >>>>> At the end of the line, some kind of hardware glue is going to be needed.
> > >>>>> 
> > >>>>> I just feel that drawing from a sample size of 1 (maybe 2 if I get to throw
> > >>>>> in the beagleboard), it is a bit premature to think about making it overly
> > >>>>> general, besides the part that are obviously part of the infrastructure 
> > >>>>> (like the DT overlay stuff).
> > >>>>> 
> > >>>>> What I'm getting at, is that we need some user experience about this, before
> > >>>>> going away and creating structure out of possible misconception about the uses. 
> > >>>> 
> > >>>> IMHO stuff like this will be needed by many SoCs. Some examples of similar
> > >>>> things for omaps that have eventually become generic frameworks have been
> > >>>> the clock framework, USB OTG support, runtime PM, pinmux framework and
> > >>>> so on.
> > >>>> 
> > >>>> So I suggest a minimal generic API from the start as that will make things
> > >>>> a lot easier in the long run.
> > >>> 
> > >>> I agree. The ux500 platform already has the concept of "user interface boards",
> > >>> which currently is not well integrated into devicetree. I believe Sascha
> > >>> mentioned that Pengutronix had been shipping some other systems with add-on
> > >>> boards and generating device tree binaries from source for each combination.
> > >>> 
> > >>> Ideally, both of the above should be able to use the same DT overlay logic
> > >>> as BeagleBone, and I'm sure there are more of those.
> > >> 
> > >> Hmm, I see. 
> > >> 
> > >> I will need some more information about the interface of the 'user interface boards'.
> > >> I.e. how is the board identified, what is typically present on those boards, etc.
> > > 
> > > User Interface Boards are mearly removable PCBs which are interchangeable
> > > amongst various hardware platforms. They are connected via numerous
> > > connectors which carry all sorts of different data links; i2c, spi, rs232,
> > > etc. The UIB I'm looking at right now has a touchscreen, speakers, a key
> > > pad, leds, jumpers, switches and a bunch of sensors.
> > > 
> > > You can find a small example of how we interface to these by viewing
> > > 'arch/arm/boot/dts/stuib.dtsi'. To add a UIB to a particular build, we
> > > currently include it as a *.dtsi from a platform's dts file.
> > 
> > I see. What I'm asking about is whether there's a method where you can read
> > an EEPROM, or some GPIO code combination where I can find out what kind of board
> > is plugged each time.
> > 
> > If there is not, there is no way to automatically load the overlays; you can always
> > use the kernel command line, or have the a user space application to request the loading
> > of a specific board's overlay.
> > 
> 
> In this case the best thing to do is announce the availability of the
> expansion via a request_firmware() call and let udev handle supplying
> the correct overlay file.

The code to load firmware files was recently removed from udev, now that
the kernel handles this automatically itself :)

But yes, the same call still applies, request_firmware() should work
fine here.

thanks,

greg k-h
