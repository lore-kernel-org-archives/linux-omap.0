From: "Danilo Caravana" <danilo.caravana@gmail.com>
Subject: Re: Changing Clock to 182MHz (14 x 13MHz) on OMAP5912...
Date: Tue, 15 Aug 2006 18:17:01 -0300
Message-ID: <e3e330af0608151417y57aa8ecav4117a7a34db645c3@mail.gmail.com>
References: <9268368b0608151351w166bce48h24378d79740d9d43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0608151351w166bce48h24378d79740d9d43@mail.gmail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

  Hi Daniel,

  I can't just put "CONFIG_OMAP_ARM_182MHZ" in the
omap_osk_5912_defconfig. Because there is no 182MHz option on <make
menuconfig>.
  I will continue looking for some workaround...
  Any help on putting the 182MHz option in the make <menuconfig> would be great.

Thanks...

Danilo

On 8/15/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> Hi Danilo,
>
> These happens likely because OSK has a 12MHz cristal...
> I think that you can change it as you suggests once you have the
> proper cristal frequency available. But redirect this query to the
> list to have more opinions. I never tried that.
>
> Please, check the frequency multipliers in the clock.h file as I
> pointed. Confirm that they are valid for 5912. Note that they are for
> a 13 MHZ cristal....
>
> Cheers,
>
> Daniel
>
>
> Hi Daniel,
>
>  It's available just for OMAP730 in <make menuconfig>.
>  For OMPA5912 i get 216/192/168... etc...
>
>  I check at omap_osk_5912_defconfig. There is no 182MHz.
>  I was wondering if i can just put: "CONFIG_OMAP_ARM_182MHZ" in the
> omap_osk_5912_defconfig.
>
>  Thanks for your help...
>
> Danilo
>
>
> On 8/15/06, Daniel Petrini <d.pensator@gmail.com> wrote:
> > Hi Danilo,
> >
> > It seems that there is this option vailable in the <make menuconfig>,
> > once there is this clock speed in the arch/arm/mach-omap1/clock.h
> > file:
> >
> > #if defined(CONFIG_OMAP_ARM_182MHZ)
> >  { 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
> > #endif
> >
> > Take a look at OSK configuration in it.
> >
> > Regards,
> >
> > Daniel
> >
> >
> > > Hi all,
> > >
> > > I have an OMAP 5912, and I need a 14 x 13MHz (182MHz) instead of 16
> > > x 12MHz (192MHz) kernel... What can i do to add this option when i
> > > build the Kernel???
> >
> > > Tkanks...
> >
> > > Danilo
> >
>
