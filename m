From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 21:54:57 +0300
Message-ID: <31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
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
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/25/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
>  > PS: I have also MMU Framework selected... this is what's causing this
> > error...
>
> I see.
>
> > > For OMAP3 the PRCM (power/reset/clock/manager) has been split into a PM
> > (power/manager) and a CRM (clock/reset/manager).  They now live in a
> > couple address spaces instead of one.  This allows the CRM to be moved
> > into a space which can be powered down when CORE is in OFF mode.  The PM
> > is in the wake power domain.
> >
> > hmmm... now I saw that... nice... but MMU FW will need modifications won't
> > it??
>
>
> Yes I suppose this file should change.
>
> Actually, this file really only makes sense for a OMAP2420 build.  The code is used with the C55-DSP+IVA1(arm7)+MMU. OMAP2430 and OMAP3430 use a different DSP system with only the C6X.

hmm.... so build dependency modifications will appear soon.

>
> If you want the DSP path to work today you need to use TI's DSP bridge code.  I expect anytime from say today to the next month for the code to be publicly available.

that's nice...


thanks for your prompt reply, richard... and only one more question.
Who's dealing the usb otg transceiver logic in omap 3430sdp ?? I
wonder tusb6010 has been left aside in this board, is that right ? Is
there any code for such transceiver publicly available yet?

thanks in advance

>
> Regards,
> Richard W.
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
