From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Mon, 29 Oct 2007 22:44:43 +0200
Message-ID: <31e679430710291344ic854dbbp8b0f5d6a84ac298d@mail.gmail.com>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Dave,

On 10/29/07, David Brownell <david-b@pacbell.net> wrote:
> > - * gadget_is_dualspeed - return true iff the hardware handles high speed
> > + * gadget_is_dualspeed - return true if the hardware handles high speed
>
> Not a typo; "iff" == "if and only if".  NAK to that part.
> Re the other, please make those parts match what's upstream;
> I think you added extra parens.
>
> Until the version of this code works on both H2 and H3, the
> two drivers will stay out of sync.  Right now the upstream
> version works on H2 (unless someone broke it somehow) and
> the one in the OMAP tree works on H3.  Sigh.  Dunno about
> other incarnations of the full speed OTG engines.

is there any plans on upgrading isp1301 driver to the new style i2c
driver also?? how could i help you with that?

tps65010 driver is really better with that i2c_board_info structure in
board files and there's a note to make isp1301 driver work the same
way.

>
> - Dave
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
