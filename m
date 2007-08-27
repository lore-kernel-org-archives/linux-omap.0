From: Tony Lindgren <tony@atomide.com>
Subject: Re: wake up from a serial port
Date: Mon, 27 Aug 2007 00:06:28 -0700
Message-ID: <20070827070626.GA30978@atomide.com>
References: <57314e840708251538l188c6ab1m6c568716c95d4ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <57314e840708251538l188c6ab1m6c568716c95d4ed1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Budhee Jamaich <budheej@gmail.com> [070827 00:00]:
> hello list,
> 
> i am working on 2430 and I need to enable
> wakeup from a serial port.
> 
> a patch which does this very thing has just been posted on lkml:
> http://article.gmane.org/gmane.linux.kernel/574545
> 
> is it relevant to me ?
> 
> or is there already a way to do that ?

You also need to use the omap serial wake-up events, or mux rx pin
temporarily to a wake-up capable GPIO pin.

Tony
