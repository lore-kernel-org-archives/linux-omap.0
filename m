From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: osk5912 webcam: surprising
Date: Fri, 25 May 2007 10:21:28 -0400
Message-ID: <20070525142128.GG3519@mvista.com>
References: <311188.55599.qm@web51404.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <311188.55599.qm@web51404.mail.re2.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: karthik <skarthikeyan_17@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2007 at 01:55:19AM -0700, karthik wrote:
> Hi
> I had earlier mailed to this group about being not able to interface a webcam via the USB interface (power budget exceeded). recently i got hold of a hub with an external power adapter. 
> 
> Now here is the funny thing
> 
> I connect the camera straight to the kit, it does NOT work (it says powerbudget exceeded).
> 
> But if I connect it via the hub WITHOUT the hub's external power adapterm,  it works (it gets registered at minor 0). I am able to record videos.
> 
> i have another hub, but shows the same power budget problem with that.
> Any explanation?? just curious (and frustrated).

Perhaps the working non-externally powered hub lied and said that it is
self powered, i.e. it does not comply with USB specs?

-- 
Regards,
George

    _____   __o   George G. Davis - Software Engineer           (o>
-------    -\<,   MontaVista Sofware - Platform to Innovate     //\
 ------ ( )/ ( )  www.mvista.com                                V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
