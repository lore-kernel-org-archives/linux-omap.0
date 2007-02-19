From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: Linux support for OMAP 850
Date: Mon, 19 Feb 2007 14:06:21 +0530
Message-ID: <2d51cbf80702190036v5fe86864i6fffc1a36d54db2f@mail.gmail.com>
References: <2d51cbf80702182130q22e7110fw39c1b47ba9bc0eea@mail.gmail.com>
	<5d5443650702182149q4af0b2ady75849e995c6588cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702182149q4af0b2ady75849e995c6588cd@mail.gmail.com>
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
> > Hi
> >
> > I think this might have been discussed here before but I couldn't
> > search/find any related topic on list (Is there any search tool for
> > this list? I couldn't find it), in case something relevant exists, any
> > pointers will be useful and apologies in advance if this causes
> > redundancy.
>
> google keywords: site:linux.omap.com OMAP850 support
>
> First link:
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-April/006891.html
>
> It has already been integrated into omap git tree. Please pull the
> tree from http://source.mvista.com/git .
>
>
> --
> --Trilok Soni
>

Hi Trilok,

Thanks for the reply. I have not looked in to the code yet and just
trying to get the high level view of the things. I am listing my
observations and inferences, please correct me if I am wrong.


1. OMAP850 has got an optimized SRAM interface for better frame buffer
performance , which OMAP730 doesnt have.

-> We need to change the frame buffer driver accordingly.

2. The OMAP 3.2 core is optimized for DDR and DMA performances.

-> Modify corresponding drivers.

3. Camera driver has to be modified.

4. compactFlash interface has to be dropped.

5. GPIO driver to be modified.

6.External DMA request line has been added, support to be provided.

7.Traffic controller burst doubler feature added to OMAP 3.2 core
cache fill performance improvement etc (I am not very clear about
this)

8. Addition of DDR memory support to SDRAM (for delay locked loop
etc,not very clear)

Is there anything else we need to do to support OMAP850? Or more
precisely, what all has been changed in Linux for OMAP 730 to make it
work for OMAP850?

If anyone can list the high level subsystem changes made, it will be a
great starting point for me. Thanks again.

-- 

Regards,
Sandeep.
