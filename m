From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Mon, 15 Apr 2013 12:14:04 +0200
Message-ID: <20130415101404.GA1952@game.jcrosoft.org>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <93BF5C62-ADE8-4EFC-9175-C2D7E43300E3@antoniou-consulting.com>
 <20130107210551.GL14149@atomide.com>
 <201301072135.05166.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201301072135.05166.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 21:35 Mon 07 Jan     , Arnd Bergmann wrote:
> (Adding Sascha Hauer, Linus Walleij, Lee Jones to Cc)
> 
> On Monday 07 January 2013, Tony Lindgren wrote:
> > > 
> > > At the end of the line, some kind of hardware glue is going to be needed.
> > > 
> > > I just feel that drawing from a sample size of 1 (maybe 2 if I get to throw
> > > in the beagleboard), it is a bit premature to think about making it overly
> > > general, besides the part that are obviously part of the infrastructure 
> > > (like the DT overlay stuff).
> > > 
> > > What I'm getting at, is that we need some user experience about this, before
> > > going away and creating structure out of possible misconception about the uses. 
> > 
> > IMHO stuff like this will be needed by many SoCs. Some examples of similar
> > things for omaps that have eventually become generic frameworks have been
> > the clock framework, USB OTG support, runtime PM, pinmux framework and
> > so on.
> > 
> > So I suggest a minimal generic API from the start as that will make things
> > a lot easier in the long run.
> 
> I agree. The ux500 platform already has the concept of "user interface boards",
> which currently is not well integrated into devicetree. I believe Sascha
> mentioned that Pengutronix had been shipping some other systems with add-on
> boards and generating device tree binaries from source for each combination.
> 
> Ideally, both of the above should be able to use the same DT overlay logic
> as BeagleBone, and I'm sure there are more of those.
I'm looking for this also as on at91 sama9x5ek and sam9cn12ek and the
sama5d3xek, we have 1 wire eeproms to detect the boards (motherboards and
daugther boards)
where we have 1 1-wire per board and cpu boards so we can detect everything
and have it's revision and more information

we already have barebox that detect the 1-wire but we need the same handling
in the kernel

Best Regards,
J.
> 
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
