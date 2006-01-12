From: Kristian Mueller <Kristian-M@kristian-m.de>
Subject: Re: build error on Linux-2.6.15-omap1
Date: Thu, 12 Jan 2006 11:21:13 +0800
Message-ID: <1137036074.11250.52.camel@pismo>
References: <20060112.135142.74755663.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060112.135142.74755663.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Hiroki

On Do, 2006-01-12 at 13:51 +0900, Hiroki Kaminaga wrote:
> [..]
> I'm building linux 2.6.15, and applied Linux-2.6.15-omap1.
> When I tried to build for OSK5912, with CONFIG_PM=y (this is default),
> [..]
> 1) mv pm.c (and Sleep.S) from plat-omap/ to mach-omap1/, or

I guess there must be something wrong with your patch since in
linux-2.6.15-omap1 pm.c and Sleep.S are already in mach-omap1 

That is since 1st december last year:
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=a57a89ee9ad70186e4f7be46e0930fcb8fb53bb6


Greetings

Kristian
-- 
