From: David Brownell <david-b@pacbell.net>
Subject: Re: 3430SDP USB driver
Date: Mon, 26 Nov 2007 11:34:37 -0800
Message-ID: <200711261134.37463.david-b@pacbell.net>
References: <D0D7E940253EF8428A27241F8E3CABA3A88DFC@zeus.Combra.se>
	<D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <D0D7E940253EF8428A27241F8E3CABA3A88DFD@zeus.Combra.se>
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
Cc: Carl Benson <Carl.Benson@combra.se>
List-Id: linux-omap@vger.kernel.org

On Monday 26 November 2007, Carl Benson wrote:
> 
> Hi. Unable to compile support for USB on 3430SDP ES1.0. Seems
> like the struct urb has changed somewhere between 2.6.22 and
> 2.6.23 and that the driver is lagging behind?  

You should be able to configure peripheral-only support.

There were some usbcore changes which haven't yet been
fully addressed.  Felipe updated Tony's patch for that,
and I don't know the status ... the kernel I produced
from Friday's GIT wouldn't boot, and I didn't make time
to sort it out yet.

- Dave
