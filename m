From: David Brownell <david-b@pacbell.net>
Subject: Re: 5912 & ASUS WL-167G with/without USB HUB?
Date: Sat, 27 May 2006 08:46:14 -0700
Message-ID: <200605270846.14620.david-b@pacbell.net>
References: <19b6ee950605270205o7fc96646t24bea6417d3cfcf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <19b6ee950605270205o7fc96646t24bea6417d3cfcf5@mail.gmail.com>
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

On Saturday 27 May 2006 2:05 am, Yuan Chia Fu wrote:
> When I use 5912 & USB HUB with Power & WL-167G and they are very good.
> 
> If I remove USB Hub with Power,5912 will show a 'power is not enough' message.
> 
> Have any body can tell me this problem's reason?

The OSK only puts out about 250 mA on its root hub port, which isn't enough
power for some peripherals.  Powered hubs put out 500 mA per port, which is
enough for all standard peripherals.

- Dave
