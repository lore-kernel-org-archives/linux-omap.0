From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: wake up from a serial port
Date: Mon, 27 Aug 2007 11:38:32 +0300
Message-ID: <57314e840708270138y2c270362i54fd928538a80a87@mail.gmail.com>
References: <57314e840708251538l188c6ab1m6c568716c95d4ed1@mail.gmail.com>
	<20070827070626.GA30978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070827070626.GA30978@atomide.com>
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

On 8/27/07, Tony Lindgren <tony@atomide.com> wrote:
> * Budhee Jamaich <budheej@gmail.com> [070827 00:00]:
> > i am working on 2430 and I need to enable
> > wakeup from a serial port.
> >
> > a patch which does this very thing has just been posted on lkml:
> > http://article.gmane.org/gmane.linux.kernel/574545
> >
> > is it relevant to me ?
> >
> > or is there already a way to do that ?
>
> You also need to use the omap serial wake-up events, or mux rx pin
> temporarily to a wake-up capable GPIO pin.

Are there any examples how to do either of these ?

If I mux the rx pin to a wake-up capable GPIO pin - should I still apply the
patch I mentioned above ?

(And how can I do this muxing ? Is there an API for that ?)

Thank you very much Tony.

Budhee
