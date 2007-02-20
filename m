From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: Linux support for OMAP 850
Date: Tue, 20 Feb 2007 16:36:25 +0530
Message-ID: <2d51cbf80702200306x66143ec4xea3d053210e9ea06@mail.gmail.com>
References: <2d51cbf80702182130q22e7110fw39c1b47ba9bc0eea@mail.gmail.com>
	<5d5443650702182149q4af0b2ady75849e995c6588cd@mail.gmail.com>
	<2d51cbf80702190036v5fe86864i6fffc1a36d54db2f@mail.gmail.com>
	<5d5443650702190411g1b968747n4c15166008f4f323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702190411g1b968747n4c15166008f4f323@mail.gmail.com>
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
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 2/19/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> On 2/19/07, sandeep lahane <sandeep.lahane@gmail.com> wrote:
> > >
> >
> > Hi Trilok,
> >
> > Thanks for the reply. I have not looked in to the code yet and just
> > trying to get the high level view of the things. I am listing my
> > observations and inferences, please correct me if I am wrong.
> >
> >
> > 1. OMAP850 has got an optimized SRAM interface for better frame buffer
> > performance , which OMAP730 doesnt have.
> >
> > -> We need to change the frame buffer driver accordingly.
> >
> > 2. The OMAP 3.2 core is optimized for DDR and DMA performances.
> >
> > -> Modify corresponding drivers.
> >
> > 3. Camera driver has to be modified.
> >
> > 4. compactFlash interface has to be dropped.
> >
> > 5. GPIO driver to be modified.
> >
> > 6.External DMA request line has been added, support to be provided.
> >
> > 7.Traffic controller burst doubler feature added to OMAP 3.2 core
> > cache fill performance improvement etc (I am not very clear about
> > this)
>
> Please follow board-fsample.c for example. As OMAP730 and 850 are very
> much similar, cpu_is_omap7xx() stuff should work for your board. BTW,
> are you working 850 based custom board or EVM?. Please read
> Documentation/arm/omap/README. Most of the generic api/drivers stuff
> in arch/arm/plat-omap/ and mach-omap1 should work for you.
>
> First get basic kernel with serial port driver working, then think of
> adding other drivers like camera.
>
> --
> --Trilok Soni
>


I am working on OMAP 850 based custom board. I think in this case,
apart from most of the generic drivers which might work (since 850 and
730 are similar), I might need to do some board specific stuff too.
-- 

Regards,
Sandeep.
