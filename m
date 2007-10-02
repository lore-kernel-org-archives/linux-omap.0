From: David Brownell <david-b@pacbell.net>
Subject: Re: problems with backlight
Date: Tue, 02 Oct 2007 11:16:25 -0700
Message-ID: <20071002181625.5A7E3236AAE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <ae36f8040710021057o34d666eaj914cd57ccffc3773@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040710021057o34d666eaj914cd57ccffc3773@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lvcargnini@gmail.com, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>   CC [M]  drivers/video/backlight/omap_bl.o
> drivers/video/backlight/omap_bl.c: In function 'omapbl_suspend':
> drivers/video/backlight/omap_bl.c:79: error: 'struct backlight_device' has
> no member named 'class_dev'
>
>	...
>
> someone have figured this problem before ?

Yes.


> can I make the fix ?

Why wouldn't you be able to?


> There is no fix, no problem I'm just creating one ?

It's obvious what happened.  The interface changed so it
no longer uses "struct class_device".  But since omap_bl
isn't in the main kernel.org tree, it wasn't updated with
the other backlight drivers.
