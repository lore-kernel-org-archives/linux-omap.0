From: Ari Saastamoinen <arzka@gamedude.fi>
Subject: Re: Cannot ping localhost
Date: Fri, 13 Jul 2007 13:23:37 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0707131322340.2465@titan.hyper.fi>
References: <395493.54739.qm@web72703.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <395493.54739.qm@web72703.mail.tp2.yahoo.com>
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

On Fri, 13 Jul 2007, simonchu47@yahoo.com.tw wrote:

> # ping localhost
> ping: bad address 'localhost'

> 127.0.0.1               localhost.localdomain
> localhost

Is that really TWO lines? Or did email program add that newline?

> But it doesn't work. Can anybody tell me why?

If I remember correctly there is an option to use builtin hostname 
resolver in busybox. Are you using it or are you using resolver offered by 
libc? What libc version you are using? If glibc, are you using dynamic or 
static nss libraries? If dynamic, do you have libnss_files installed? Is 
the nsswitch.conf configured correctly?

-- 
Arzka
