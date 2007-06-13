From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 0/3] Update menelaus chip driver to new I2C core changes
Date: Wed, 13 Jun 2007 11:18:08 +0530
Message-ID: <5d5443650706122248w62777dbk3646ce9be4786ba7@mail.gmail.com>
References: <5d5443650705260125r2d424136g51f68f1d0d107a39@mail.gmail.com>
	<5d5443650706080400s505b38b6jc0cc61ebcb32d119@mail.gmail.com>
	<20070612135836.GJ28834@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070612135836.GJ28834@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 6/12/07, Tony Lindgren <tony@atomide.com> wrote:
> * Trilok Soni <soni.trilok@gmail.com> [070608 04:00]:
> > Tony,
> >
> > On 5/26/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> >> Tony/David,
> >>
> >> First two patches are same as the patch I have sent earlier as WIP.
> >> Third patch has changes related to n800 board and it is compile-tested
> >> only. Please see that I have removed board-n800-pm.c in the 3rd patch,
> >> if not accepted then please suggest better way to integrate with
> >> menelaus-i2c changes.
> >>
> >
> > Please consider these patches for omap-git or do I need to rebase?
>
> Can you please rebase? Looks like there is one comment from Dave
> regarding the omap_cfg_reg() that should be removed. Or else I'm just
> having hard time keeping up :)

omap_cfg_reg() is already removed from menelaus.c in the follow up
patch posted by David here.

http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010105.html

>
> Please also post Dave's patches in your series with From: as needed.
>

I will try to rebase and post the patches.

-- 
--Trilok Soni
