From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Error compiling after cg-update
Date: Sun, 25 Jun 2006 18:02:53 +0200
Message-ID: <449EB3AD.3050403@gmail.com>
References: <ae36f8040606231421t190bf34kc704214290678d51@mail.gmail.com>
	<1151100463.27204.258.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1151100463.27204.258.camel@vence.internal.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@deeprooted.net>, lvcargnini@ieee.org
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> You must be using gcc4.  Apply my gcc4 patch from yesterday to fix this
> problem.  I'll be pushing it soon.

Just fyi: My gcc 4.1.0 (you know, that one with the ALSA 
optimization issue ;) ) compiles this okay using recent git. 
And the gcc4 clock.h patch is already applied.

Dirk
