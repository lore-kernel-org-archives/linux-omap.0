From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/2] 3430 clock: add emulation clocks
Date: Tue, 6 Nov 2007 02:54:43 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711060252540.25907@utopia.booyaka.com>
References: <20071105082406.387923286@pwsan.com>
	<20071105082528.483327389@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429026298DF@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429026298DF@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 5 Nov 2007, Woodruff, Richard wrote:

> > Add clocks for the EMU domain for OMAP3430.  These clocks are not
> > well-documented in the TRM, beyond register bit settings.  Some
> > information is available in the ARM Cortex-A8 TRM, section 10.1.  Also
> > rename existing emul_* clocks to emu_* to conform with recent TRMs.
> 
> There are TRM addendums for emulations which have much more information.
> You at times need more than the base TRM these days.  There are probably
> a couple thousand more pages removed :) You wouldn't want to have too
> big of TRM, 43Meg is just the right size.

Ok, thanks.  Are you referring to the Emulation TRM, or are there other 
TRMs related to emulation that include this information?  Let me know and 
I will repost the patches with an updated commit-msg pointing people there.


- Paul
