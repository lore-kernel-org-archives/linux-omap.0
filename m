From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Mon, 29 Oct 2007 14:33:03 -0700
Message-ID: <20071029213303.257D523C3E9@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<31e679430710291344ic854dbbp8b0f5d6a84ac298d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710291344ic854dbbp8b0f5d6a84ac298d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: felipebalbi@users.sourceforge.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> is there any plans on upgrading isp1301 driver to the new style i2c
> driver also?? how could i help you with that?

ISTR sending some code like that to the I2C list a while back, but
it's not yet been merged.

You could finish that, if it's not already sitting in Jean's I2C queue.
And if it is, you could maybe get it into the OMAP tree before 2.6.25
merges begin.  :)


> tps65010 driver is really better with that i2c_board_info structure in
> board files and there's a note to make isp1301 driver work the same
> way.

Yep.  In fact, all the I2C code that OMAP uses should switch
over to new-style drivers ...

That includes the pcf875x i/o expanders found on many TI devel
boards.  Making that change involves some updates to the GPIO
framework.  I've got some code to address all that, which I'll
be posting in a few days.

- Dave
