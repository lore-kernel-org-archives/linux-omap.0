From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: move mailbox.h out of plat-omap headers
Date: Tue, 30 Oct 2012 14:02:13 -0700
Message-ID: <20121030210213.GA6098@kroah.com>
References: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
 <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
 <20121029175228.GD11908@atomide.com>
 <CALLhW=4ukBuRSVcPm2A37PgBhv33yKqk2G=Dz2XTUyswXw=JMg@mail.gmail.com>
 <20121030162441.GF11908@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20121030162441.GF11908@atomide.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devel@driverdev.osuosl.org, Suman Anna <s-anna@ti.com>, Russell King <linux@arm.linux.org.uk>, Juan Gutierrez <jgutierrez@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 30, 2012 at 09:24:42AM -0700, Tony Lindgren wrote:
> * Omar Ramirez Luna <omar.luna@linaro.org> [121030 05:20]:
> > Tony,
> > 
> > On 29 October 2012 12:52, Tony Lindgren <tony@atomide.com> wrote:
> > >> --- /dev/null
> > >> +++ b/include/linux/platform_data/omap_mailbox.h
> > >> @@ -0,0 +1,105 @@
> > >
> > > This file should only contain pure platform data needed
> > > by the core omap code to pass to the mailbox driver.
> > 
> > Ok, looking at it closely, this header file is related to the API
> > itself, there is nothing that could be actually considered as pure
> > platform data, the structures are related with the mailbox framework
> > and even if I split this file into two, the additional header would
> > end up including the "platform_data" header unless I move
> > save/restore_ctx functions and then export them as symbols for the
> > API.
> > 
> > So, it might be better for the entire file to sit in
> > linux/include/mailbox/ then.
> 
> OK to me.
>  
> > > The mailbox API header should be somewhere else,
> > > like include/linux/mailbox/mailbox-omap.h or similar.
> > 
> > Ok.
> > 
> > > But shouldn't this all now be handled by using the
> > > remoteproc framework?
> > 
> > Remoteproc doesn't handle the mailbox hardware directly, it still
> > relies in the mailbox framework for the low level communications.
> > E.g.: Proc1 has a message (virtqueue msg) queued to Proc2, uses
> > mailbox msg to generate an interrupt to Proc2, Proc2 queries the
> > message (virtqueue) based on the mailbox message received.
> 
> OK.
> 
> Greg, do these patches look OK to you to move to live under
> drivers/mailbox?

Um, I don't know, I wasn't paying attention here, sorry.

greg k-h
