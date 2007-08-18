From: David Brownell <david-b@pacbell.net>
Subject: Re: FSUSB Port on OMAP2430 SDP
Date: Fri, 17 Aug 2007 17:43:50 -0700
Message-ID: <200708171743.50855.david-b@pacbell.net>
References: <6E3DC4E6E09EF440B55B7AD683608D6D01836ABA@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <6E3DC4E6E09EF440B55B7AD683608D6D01836ABA@dlee13.ent.ti.com>
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
Cc: Amit Gupta <amit_jobs05@inbox.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 01 August 2007, Kamat, Nishant wrote:
> Its mandatory according to the USB spec, and the way the
> isp1301_omap.c driver detects the A-device/B-device mode.
> However, for testing purposes you might be able to hack
> isp1301_omap.c to allow working as a host with mini-B
> cable plugged in.

It used to be that no hacking was required ... if you set
up e.g. an H2 with only host side USB, it would ignore the
ID pin and always operate the OTG port in host-only mode.
