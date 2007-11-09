From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Fri, 9 Nov 2007 09:14:52 +0200
Message-ID: <20071109091452.e4096e71.jarkko.nikula@nokia.com>
References: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
	<1194432873-5209-3-git-send-email-jarkko.nikula@nokia.com>
	<4733044B.9070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4733044B.9070307@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 08 Nov 2007 06:42:51 -0600
"ext Nishanth Menon" <menon.nishanth@gmail.com> wrote:

> Jarkko,
> Jarkko Nikula stated on 11/7/2007 4:54 AM:
> > This patch starts using introduced I2C bus registration helper by
> > cleaning up registration currently done in various places and by
> > doing necessary board file modifications.
> 
> How do I handle Bus segments on (currently) a hypothetical situation
> where i have HS and FS devices on the same i2c bus? There was a long
> discussion
> (http://lists.lm-sensors.org/pipermail/i2c/2007-April/001038.html )
> 
> I am not sure we want to loose that flexibility..
> 
I didn't read the whole thread but I don't see that this framework can
cover that issue any other way than by registering the rate of slowest
known device since this is more device specific problem than bus
registration problem.

I think it is exception if there is a bus with variable speed devices
and where slower devices don't get confused when using higher speed with
other devices.

Probably that short of info can be passed via i2c_board_info? Like
separate device speed and max idle rate. Adapter driver uses then
standard speed when probing and min(device speed, bus rate, min{devices
max idle rate}) while communicating with one. So that maximum bus
communication speed would be limited either by device speed, bus rate or
slowest device idle rate depending which one is lowest.

But anyway. This sounds some short of exception, not standard procedure
we can do automatically?


	Jarkko
