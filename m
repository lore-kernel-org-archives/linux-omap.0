From: Tony Lindgren <tony@atomide.com>
Subject: Re: Compiling latest kernel (from kernel.org,
	linux-omap git version) in n800
Date: Thu, 26 Apr 2007 22:35:48 +0000
Message-ID: <20070426223547.GP9764@atomide.com>
References: <5bc4c4570704231118q47974273qfd36e41970a02635@mail.gmail.com>
	<31e679430704231123v6a73cc8fqd6b67918be28a5a9@mail.gmail.com>
	<5bc4c4570704231129r7bff6759xc97eedc3d8ee26c7@mail.gmail.com>
	<20070423183514.GI19866@intune.research.nokia.com>
	<5bc4c4570704231153p788a3936ue36041eeb7e06f8e@mail.gmail.com>
	<20070423185719.GJ19866@intune.research.nokia.com>
	<5bc4c4570704231216m15565ed0l8e8bb976ac8c0828@mail.gmail.com>
	<5bc4c4570704231239w32060adcq2d026e7956452064@mail.gmail.com>
	<5bc4c4570704231534o76a5dbe0oc5de23e1f5845986@mail.gmail.com>
	<20070424084013.c53f4aac.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070424084013.c53f4aac.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070424 05:46]:
> On Mon, 23 Apr 2007 19:34:34 -0300
> "ext Leandro Melo de Sales" <leandroal@gmail.com> wrote:
> 
> > Other thing just to you know. After I flash the new kernel, everything
> > (except the WLAN interface works fine), but the screen, after n800
> > enter in stand-by mode, the screen seems to lost sync. I don't know
> > how to explain exactly, so I'm sending to you some images. Sorry the
> > poor quality of the images.
> >   Before stand-by the screen is like DSC01927.JPG. After standy-by,
> > like DSC01921.JPG.
> >   When I say stand-by I mean after the user stop to use for about
> > 1min.
> > 
> This patch should fix the problem:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009478.html

This patch should be already applied.

Tony
