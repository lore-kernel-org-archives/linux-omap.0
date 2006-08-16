From: "Danilo Caravana" <danilo.caravana@gmail.com>
Subject: Re: Changing Clock to 182MHz (14 x 13MHz) on OMAP5912...
Date: Wed, 16 Aug 2006 09:40:14 -0300
Message-ID: <e3e330af0608160540i7484d58bxc2159ce8e20e2f53@mail.gmail.com>
References: <9268368b0608160500v2f710340we437abe9edebbc57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0608160500v2f710340we437abe9edebbc57@mail.gmail.com>
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
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

  Hi Daniel...

  I=B4ll Try this workaround...
  I=B4m studing some references on OMAP Clocks.

  As soon as I test, i let you know...

  Regards and Thanks...

Danilo

On 8/16/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> Hi Danilo,
>
> > I can't just put "CONFIG_OMAP_ARM_182MHZ" in the
> > omap_osk_5912_defconfig. Because there is no 182MHz option on <make
> > menuconfig>.
>
> Due to the lack of a 13 MHz cristal in the default configuration...
>
> > I will continue looking for some workaround...
> > Any help on putting the 182MHz option in the make <menuconfig> would be=
 great.
>
> There is an ugly workaround:
> You can force it by editing resulting .config file, I guess.
> To do so, select 192 MHz normally in make menuconfig and then edit
> .config file, find the CONFIG_OMAP_ARM_192MHZ and exchange it for
> CONFIG_OMAP_ARM_182MHZ.
> Then make as usual.
> If there is any other dependency you will need to resolv each of them.
> Note that you are beyond valid and tested configurations.
>
> Regards and good luck,
>
> Daniel
>
>
> On 8/15/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> > Hi Danilo,
> >
> > These happens likely because OSK has a 12MHz cristal...
> > I think that you can change it as you suggests once you have the
> > proper cristal frequency available. But redirect this query to the
> > list to have more opinions. I never tried that.
> >
> > Please, check the frequency multipliers in the clock.h file as I
> > pointed. Confirm that they are valid for 5912. Note that they are for
> > a 13 MHZ cristal....
> >
> > Cheers,
> >
> > Daniel
> >
> >
> > Hi Daniel,
> >
> >  It's available just for OMAP730 in <make menuconfig>.
> >  For OMPA5912 i get 216/192/168... etc...
> >
> >  I check at omap_osk_5912_defconfig. There is no 182MHz.
> >  I was wondering if i can just put: "CONFIG_OMAP_ARM_182MHZ" in the
> > omap_osk_5912_defconfig.
> >
> >  Thanks for your help...
> >
> > Danilo
> >
> >
> > On 8/15/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> > > Hi Danilo,
> > >
> > > It seems that there is this option vailable in the <make menuconfig>,
> > > once there is this clock speed in the arch/arm/mach-omap1/clock.h
> > > file:
> > >
> > > #if defined(CONFIG_OMAP_ARM_182MHZ)
> > >  { 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 *=
/
> > > #endif
> > >
> > > Take a look at OSK configuration in it.
> > >
> > > Regards,
> > >
> > > Daniel
> > >
> > >
> > > > Hi all,
> > > >
> > > > I have an OMAP 5912, and I need a 14 x 13MHz (182MHz) instead of 16
> > > > x 12MHz (192MHz) kernel... What can i do to add this option when i
> > > > build the Kernel???
> > >
> > > > Tkanks...
> > >
> > > > Danilo
> > >
>
