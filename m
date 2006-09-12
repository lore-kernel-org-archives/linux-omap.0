From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending August patches
Date: Tue, 12 Sep 2006 15:03:29 +0300
Message-ID: <20060912120328.GD22547@atomide.com>
References: <44F85C99.7080102@gmail.com>
	<fb249edb0609011004k75484eejae4c583d933bfe01@mail.gmail.com>
	<20060904150433.GC8017@atomide.com>
	<20060905154109.GE18073@atomide.com>
	<fb249edb0609111626h37d8d971tfc8be67b74134490@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609111626h37d8d971tfc8be67b74134490@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060912 02:27]:
> On 05/09/06, tony@atomide.com <tony@atomide.com> wrote:
> >OK, I've pushed Dirk's list except for the ones commented below.
> >Please check your patches got merged OK.
> >
> >8. [PATCH 1/5] Change all omap15xx devices to use similar DMA handling 
> >than h6300 uses.
> >http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007777.html
> >
> >Already applied.
> 
> It doesn't appear these two patches are merged yet. Am I looking at a
> wrong place?
> 
> >
> >9. [PATCH 2/5] Removed double spinlocking with omap15xx devices.
> >http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007778.html
> >
> >Already applied.

Thanks for noticing. I must have tried to apply these two patches
twice before committing somehow which made me think they're
already applied.. Pushing them today.

Regards,

Tony
