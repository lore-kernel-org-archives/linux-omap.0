From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Mon, 29 Oct 2007 13:11:14 -0700
Message-ID: <20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <47263ACA.8010001@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <47263ACA.8010001@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, dirk.behme@googlemail.com
List-Id: linux-omap@vger.kernel.org

> - * gadget_is_dualspeed - return true iff the hardware handles high speed
> + * gadget_is_dualspeed - return true if the hardware handles high speed

Not a typo; "iff" == "if and only if".  NAK to that part.
Re the other, please make those parts match what's upstream;
I think you added extra parens.

Until the version of this code works on both H2 and H3, the
two drivers will stay out of sync.  Right now the upstream
version works on H2 (unless someone broke it somehow) and
the one in the OMAP tree works on H3.  Sigh.  Dunno about
other incarnations of the full speed OTG engines.

- Dave
