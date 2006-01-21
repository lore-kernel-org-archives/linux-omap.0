From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sat, 21 Jan 2006 01:41:32 +0100
Message-ID: <fb249edb0601201641le9460dr@mail.gmail.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
	<20060115201949.GF5905@atomide.com>
	<fb249edb0601161523q70fc0ba1n@mail.gmail.com>
	<20060120195352.GB6683@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060120195352.GB6683@atomide.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 20/01/06, tony@atomide.com <tony@atomide.com> wrote:
> OK, I've pushed linux-palmte-errors.patch in three separate patches.

Thank you!

> Where did find out the mclk for 15xx entry, BTW? Just trying out the
> bits?

Basically yes, but it took only 3 tries since the values are #defined
in drivers/ssi/omap-tsc2101.c and for some reason unused.
Without that the TSC2301 driver wouldn't work and I wasn't sure if it
would be correct to set the values dynamically from inside the TSC2301
driver or some other place.
Regards,
Andrew
