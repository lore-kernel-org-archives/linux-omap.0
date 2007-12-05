From: David Brownell <david-b@pacbell.net>
Subject: Re: LCD Backlight control
Date: Wed, 5 Dec 2007 13:24:25 -0800
Message-ID: <200712051324.26035.david-b@pacbell.net>
References: <E1067FCAA4D74F4DB1DD9FBA2CE84A97B93FD5@dnce04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <E1067FCAA4D74F4DB1DD9FBA2CE84A97B93FD5@dnce04.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: "Agarwal, Vivek" <vagarwal@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 December 2007, Agarwal, Vivek wrote:
> 
> Is there a API/IOCTL calls exposed by the LCD driver on OMAP 2430 SDP or
> any OMAP SDP to control the backlight intensity? 

If you use the standard interface, it exposes sysfs attributes.
One example is the drivers/video/backlight/omap_bl.c which works
on at least OSK + Mistral for PWM-based brightness.

(I don't know any reason that driver shouldn't go upstream, BTW;
most other OSK support is already there.)

- Dave
