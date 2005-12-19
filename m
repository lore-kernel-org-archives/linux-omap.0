From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] fix watchdog
Date: Mon, 19 Dec 2005 18:20:05 +0200
Message-ID: <1135009205.12906.28.camel@two.research.nokia.com>
References: <20051218140922.88154.qmail@web32915.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051218140922.88154.qmail@web32915.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2005-12-18 at 06:09 -0800, ext Komal Shah wrote:

> Change .driver_name from "omap-wdt" to "omap_wdt".

Why?

Instead of explaining _what_ you do in the patch comments, you should
explain _why_, especially in the case of a trivial patch like this.

Cheers,
Juha
