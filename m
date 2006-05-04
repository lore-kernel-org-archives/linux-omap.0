From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: init (busybox) problem on OSK5912
Date: Wed, 3 May 2006 23:47:08 -0700 (PDT)
Message-ID: <20060504064708.22877.qmail@web52314.mail.yahoo.com>
References: <20060503194919.7EDC38062D@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060503194919.7EDC38062D@linux.omap.com>
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

I'm replying to my own query to give update ....

I managed to have init working by using an older
version of busybox (1.00-pre8), however another
problem happens with /bin/sh (ash) crashing and
restarting over and over.

The problem seems to happen only when busybox is
compiled with shared libraries. other busybox applets
(like ls -l) also terminate with segmentation fault.
strace shows that they seg fault when connecting or
binding to a socket.

any thoughts why these only happen with shared
libraries?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
