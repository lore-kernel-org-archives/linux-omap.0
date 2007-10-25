From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: OMAP3 & PRCM register ??
Date: Thu, 25 Oct 2007 22:42:41 +0300
Message-ID: <31e679430710251242g4e0eb2f5g7d02978d2d79ed70@mail.gmail.com>
References: <31e679430710251056p467b7161tccf52693745ba0eb@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253046F@dlee13.ent.ti.com>
	<31e679430710251124w70f370c5of30b209eacbf8753@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025304BF@dlee13.ent.ti.com>
	<31e679430710251154p4f87f124h181ffc6a2a8c8dc1@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290253052A@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290253052A@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/25/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > thanks for your prompt reply, richard... and only one more question.
> > Who's dealing the usb otg transceiver logic in omap 3430sdp ?? I
> > wonder tusb6010 has been left aside in this board, is that right ? Is
> > there any code for such transceiver publicly available yet?
>
> I think Nishanth got this.  I'll elaborate a bit more.
>
> The IP block which the external tusb6010 chip uses is integrated inside of the omap34xx (and 243x).  No need for an external chip to get HS-USB.  Probably the main driver difference is DMA usage and transceiver setup I suppose.
>
> On current SDPs this internal HS-USB block is talking to the companion IO chip (T2) which among other things has a USB transceiver.
>
> TI 2430 and 3430 images have necessary code to make all this work for OTG.  There likely is some work in merging it back into the latest omap-git.
>

I suppose you mean internal TI linux kernel trees here... Is there any
plans for releasing this code ?
I'm really interested in seeing this happening, after working on tusb
i'd like to keep going with omap 2430 and omap3 support...

> Regards,
> Richard W.
>
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
