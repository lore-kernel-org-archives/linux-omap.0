From: David Brownell <david-b@pacbell.net>
Subject: Re: I2C zero length transfers and SMBUS_QUICK,
	was: Pending October patches
Date: Sun, 5 Nov 2006 17:37:10 -0800
Message-ID: <200611051737.11242.david-b@pacbell.net>
References: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
	<454DBDC7.70706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <454DBDC7.70706@gmail.com>
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

On Sunday 05 November 2006 2:32 am, Dirk Behme wrote:
>
> Our hack to make things work on OMAP will not be accepted 
> upstream. But staying with broken OMAP features only because 
> (available) hack isn't acceptable in mainline doesn't sound 
> like an option as well.
> 
> I personally vote for working OMAP ;)

Me too ... the sad part is that this is basicallly a design bug
in the upstream I2C stack, and over the past couple years there
have been no evident signs of it ever getting fixed.

- Dave
