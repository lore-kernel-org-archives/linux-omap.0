From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Fri, 17 Aug 2007 16:36:26 -0400
Message-ID: <31e679430708171336g318ad89er59e9246c5c839f04@mail.gmail.com>
References: <46C5C233.5090405@googlemail.com>
	<200708170957.44311.david-b@pacbell.net>
	<31e679430708171114o565ee910o2002a0bf98865c90@mail.gmail.com>
	<200708171130.21974.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708171130.21974.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 8/17/07, David Brownell <david-b@pacbell.net> wrote:
> On Friday 17 August 2007, Felipe Balbi wrote:
> > Hi,
> >
> > On 8/17/07, David Brownell <david-b@pacbell.net> wrote:
> > > > this doesn't look right since any device can issue SRP. It's better
> > > > for you to use it somewhere on DaVinci.
> > >
> > > That "issue SRP" attribute has no business being specific to any
> > > particular platform.
> > >
> >
> > This is needed during USB OTG Compliance program... and it looks to me
> > really architecture dependent, if you have a better way for doing
> > this, please tell me and I'll try it.
>
> Pure devices can issue SRP, hardware allowing.  So it's incorrect
> to have this #ifdeffed for OTG.  That's in addition to the compiler
> warnings you get when building with a pure

Maybe my previous mail didn't get to list yet but I sent an email
telling Dirk to get rid of the ifdef CONFIG_USB_MUSB_OTG.

Does that seem better for you?


Thanks

>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
