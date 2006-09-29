From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Palm Tungsten E board update
Date: Fri, 29 Sep 2006 14:07:58 +0300
Message-ID: <20060929110757.GD19674@atomide.com>
References: <fb249edb0609230339h66a97190r9f7f5408c688652c@mail.gmail.com>
	<20060928140440.GK29453@atomide.com>
	<fb249edb0609281322u45c15f32wf62a92940aa6eab0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609281322u45c15f32wf62a92940aa6eab0@mail.gmail.com>
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
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060928 23:22]:
> On 28/09/06, Tony Lindgren <tony@atomide.com> wrote:
> >* andrzej zaborowski <balrog@zabor.org> [060923 13:45]:
> >> General update of the board file for Palm Tungsten E. Registers the
> >> platform devices contained in the PDA (ROM chip, keypad, infra-red)
> >> and updates the configuration for USB and MMC, whose config values
> >> were previously guessed in most cases due to lack of documentation
> >> (and now are confirmed by a number of users). Macros for GPIO pins are
> >> moved to a file in include/asm-arm/arch-omap.
> >>
> >> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> >
> >Pushing today.
> 
> Many thanks.
> One thing though: the patch added a new file at
> include/asm-arm/arch-omap/board-palmte.h which didn't get merged and
> include/asm-arm/arch-omap/hardware.h now tries to #include the file.
> Can you add this header? (the attached diff contains this file alone)

Sorry, looks like I forgot to run git status again to see new files..

I'll revert and reapply your patch, that way the original patch will go
upstream.

Regards,

Tony
