From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Sat, 4 Oct 2008 07:05:35 +0000
Message-ID: <20081004070534.GB30190@muru.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
	<dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: twebb <taliaferro62@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 03, 2008 at 11:52:53AM -0400, twebb wrote:
> > Hi all,
> >
> > Here are few patches to add minimal omap34xx support, and
> > board files for Beagle and Overo boards.
> >
> > The minimal omap34xx support patch was previously posted here
> > with the omap2 patches, this patch has some additions, such
> > as sram support.
> >
> > For folks who are wondering what the Beagle and Overo boards
> > are, here are some links:
> >
> > http://beagleboard.org/
> > http://www.gumstix.net/Overo/cat/Overo/115.html
> >
> 
> Where does the OMAP35x EVM fall into the mix?  I see that most patches
> seem to be targeted, or at least tested, on the beagle, overo, or
> omap3 sdp boards.  Do TI and/or Mistal (maker of OMAP35x EVM) do any
> testing/verification of patches on the 35x EVM?

Yeah there is active development going on in linux-omap mailing list
for the EVMs too. And Mistral's older 5912OSK is probably the best
supported omap board in the mainline kernel.

Basically adding new boards is just a question of adding the board-*.c
file, and .config for the drivers to include. Some board of course
have custom devices too.

Anyways, we'll add more boards to the mainline kernel later on, but
first we have to get the the minimal omap3 support working with
mainline kernel.

Tony

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
