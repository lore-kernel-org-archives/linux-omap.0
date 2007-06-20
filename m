From: "arun c" <arun.edarath@gmail.com>
Subject: Re: Help regarding X-loader
Date: Wed, 20 Jun 2007 10:44:30 +0530
Message-ID: <c656a4d20706192214g15dc9a58le65053fa6aa9625@mail.gmail.com>
References: <c656a4d20706192149s47252c52q6e44d9701be1001c@mail.gmail.com>
	<0A50DBE80DD6674E94F7269DC964A7B6093E65@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <0A50DBE80DD6674E94F7269DC964A7B6093E65@dbde01.ent.ti.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

Sriram thank you very much for the reply. I got a breif idea.

I found X-loader source code in linux.omap.com for omap2430SDP.
My board is having a processor with pop memory.

can i directly use this x-loder for my board with out any
modifications?

Thanks in advance
Arun


On 6/20/07, Sriram, Kannan <ksriram@ti.com> wrote:
>
> Arun,
>
>  You need the X-loader only in case of a NAND based system. For NOR
> flash based systems, you don't need an X-loader.
>
>  The X-loader is typically a "pre-boot" boot-loader, whose only job is
> to perform basic platform setup (clock setup, pin-muxing, and memory
> configuration), and load the u-boot from NAND flash -> external SDRAM.
> This is because u-boot cannot do XIP on NAND based systems.
>
> Regards,
> Sriram.
>
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of arun c
> > Sent: Wednesday, June 20, 2007 1:50 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: Help regarding X-loader
> >
> > Hi all,
> >
> > I am a new guy stepping into the world of porting.
> >
> > My aim is to port linux to omap2430SDP with pop memory processor
> board.
> > I want to use U-boot as my bootloader.But i came to know that it
> > requires one more
> > thing called X-loader. I don't understand why it need X-loader. Does
> > anybody here
> > know the answer please help me. It will be very helpful if somebody is
> > giving me
> > a brief description about the working of x-loader.
> >
> >
> > Thanks in advance
> > Arun
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
