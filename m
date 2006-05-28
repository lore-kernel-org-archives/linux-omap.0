From: David Brownell <david-b@pacbell.net>
Subject: Re: Undefined usb_disconnect
Date: Sun, 28 May 2006 09:17:58 -0700
Message-ID: <200605280917.59002.david-b@pacbell.net>
References: <4452384E.7080409@gmail.com>
	<200605270843.54940.david-b@pacbell.net>
	<4479A3D8.5070507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4479A3D8.5070507@gmail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 28 May 2006 6:21 am, Dirk Behme wrote:
> Okay, hanks for the patch! I think we should apply it until
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007071.html
> 
> is reworked and ready for inclusion.

I think it should be applied, and some Tahvo-specific stuff applied
on top of it.  Notice how the OHCI-specific bits in my patch were a
superset of the patch from Hiroshi ...

- Dave
